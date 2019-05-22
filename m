Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30683C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDCF21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfEVNZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:25:43 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:50018 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbfEVNZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 9E9E123F9C5;
        Wed, 22 May 2019 15:25:38 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dK085gI_J9hg; Wed, 22 May 2019 15:25:37 +0200 (CEST)
Received: from [192.168.1.127] (host-091-097-246-171.ewe-ip-backbone.de [91.97.246.171])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 3B50524129B;
        Wed, 22 May 2019 15:25:37 +0200 (CEST)
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation warnings
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190521211714.1395-1-corbet@lwn.net> <87d0kb7xf6.fsf@intel.com>
 <20190522071909.050bb227@coco.lan>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <39b12927-9bf9-a304-4108-8f471a204f89@darmarit.de>
Date:   Wed, 22 May 2019 15:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522071909.050bb227@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.05.19 um 12:19 schrieb Mauro Carvalho Chehab:
> Em Wed, 22 May 2019 10:36:45 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> 
>> On Tue, 21 May 2019, Jonathan Corbet <corbet@lwn.net> wrote:
>>> The Sphinx folks are deprecating some interfaces in the upcoming 2.0
>>> release; one immediate result of that is a bunch of warnings that show up
>>> when building with 1.8.  These two patches make those warnings go away,
>>> but at a cost:
>>>
>>>   - It introduces a couple of Sphinx version checks, which are always
>>>     ugly, but the alternative would be to stop supporting versions
>>>     before 1.7.  For now, I think we can carry that cruft.
>>
>> Frankly, I'd just require Sphinx 1.7+, available even in Debian stable
>> through stretch-backports.
> 
> We can raise the bar and force a 1.7 or even 1.8 (Fedora 30 comes
> with version 1.8.4), but I would prefer to keep support older versions,
> at least while we don't depend on some new features introduced after
> the version we're using, and while our extensions won't require a major
> rework due to a new version.

Lets use 1.7 :

- no need for Use_SSI wrapper
- new log should work with 1.7 [1] --> no need for kernellog.py and
   additional imports, instead include on top of python modules ::

     from sphinx.util import logging
     logger = logging.getLogger('kerneldoc')

[1] 
https://github.com/sphinx-doc/sphinx/commit/6d4e6454093953943e79d4db6efeb17390870e62


BTW we can drop other (old) sphinx-version issues e.g.
Documentation/conf.py  which fails with version 2.0:

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 72647a38b5c2..ba82715b6715 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -34,13 +34,7 @@ needs_sphinx = '1.3'
  # Add any Sphinx extension module names here, as strings. They can be
  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
  # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 
'kfigure', 'sphinx.ext.ifconfig']
-
-# The name of the math extension changed on Sphinx 1.4
-if major == 1 and minor > 3:
-    extensions.append("sphinx.ext.imgmath")
-else:
-    extensions.append("sphinx.ext.pngmath")
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 
'kfigure', 'sphinx.ext.ifconfig', 'sphinx.ext.imgmath']

  # Add any paths that contain templates here, relative to this directory.
  templates_path = ['_templates']

-- Markus --

