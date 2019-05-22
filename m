Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE1C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F49217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfEVHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:35:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:30009 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfEVHfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:35:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 00:35:34 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 00:35:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] doc: Cope with the deprecation of AutoReporter
In-Reply-To: <20190521211714.1395-3-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190521211714.1395-1-corbet@lwn.net> <20190521211714.1395-3-corbet@lwn.net>
Date:   Wed, 22 May 2019 10:38:50 +0300
Message-ID: <87a7ff7xbp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> AutoReporter is going away; recent versions of sphinx emit a warning like:
>
>   /stuff/k/git/kernel/Documentation/sphinx/kerneldoc.py:125:
>       RemovedInSphinx20Warning: AutodocReporter is now deprecated.
>       Use sphinx.util.docutils.switch_source_input() instead.
>
> Make the switch.  But switch_source_input() only showed up in 1.7, so we
> have to do ugly version checks to keep things working in older versions.
> ---
>  Documentation/sphinx/kerneldoc.py | 38 ++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index e8891e63e001..d3216f7b4170 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -37,7 +37,17 @@ import glob
>  from docutils import nodes, statemachine
>  from docutils.statemachine import ViewList
>  from docutils.parsers.rst import directives, Directive
> -from sphinx.ext.autodoc import AutodocReporter
> +
> +#
> +# AutodocReporter is only good up to Sphinx 1.7
> +#
> +import sphinx
> +
> +Use_SSI = sphinx.__version__[:3] >= '1.7'
> +if Use_SSI:
> +    from sphinx.util.docutils import switch_source_input
> +else:
> +    from sphinx.ext.autodoc import AutodocReporter
>  
>  import kernellog
>  
> @@ -125,13 +135,7 @@ class KernelDocDirective(Directive):
>                      lineoffset += 1
>  
>              node = nodes.section()
> -            buf = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
> -            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
> -            self.state.memo.title_styles, self.state.memo.section_level = [], 0
> -            try:
> -                self.state.nested_parse(result, 0, node, match_titles=1)
> -            finally:
> -                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
> +            self.do_parse(result, node)
>  
>              return node.children
>  
> @@ -140,6 +144,24 @@ class KernelDocDirective(Directive):
>                             (" ".join(cmd), str(e)))
>              return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
>  
> +    def do_parse(self, result, node):
> +        if Use_SSI:
> +            save = self.state.memo.title_styles, self.state.memo.section_level
> +            try:
> +                with switch_source_input(self.state, result):
> +                    self.state.nested_parse(result, 0, node, match_titles=1)

IIUC you don't need to save the state anymore, so the above two lines
should be sufficient when using switch_source_input.

BR,
Jani.


> +            finally:
> +                self.state.memo.title_styles, self.state.memo.section_level = save
> +        else:
> +            save = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
> +            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
> +            self.state.memo.title_styles, self.state.memo.section_level = [], 0
> +            try:
> +                self.state.nested_parse(result, 0, node, match_titles=1)
> +            finally:
> +                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = save
> +
> +
>  def setup(app):
>      app.add_config_value('kerneldoc_bin', None, 'env')
>      app.add_config_value('kerneldoc_srctree', None, 'env')

-- 
Jani Nikula, Intel Open Source Graphics Center
