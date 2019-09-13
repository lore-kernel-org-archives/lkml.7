Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D69C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1832081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfIMVsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:48:53 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:39734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731274AbfIMVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:48:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 99727100E86C1;
        Fri, 13 Sep 2019 21:48:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hen01_301fba1184944
X-Filterd-Recvd-Size: 2653
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 21:48:50 +0000 (UTC)
Message-ID: <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 13 Sep 2019 14:48:49 -0700
In-Reply-To: <20190913211349.28245-1-robh@kernel.org>
References: <20190913211349.28245-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> DT bindings are moving to using a json-schema based schema format
> instead of freeform text. Add a checkpatch.pl check to encourage using
> the schema for new bindings. It's not yet a requirement, but is
> progressively being required by some maintainers.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2822,6 +2822,14 @@ sub process {
>  			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>  		}
>  
> +# Check for adding new DT bindings not in schema format
> +		if (!$in_commit_log &&
> +		    ($line =~ /^new file mode\s*\d+\s*$/) &&
> +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> +			WARN("DT_SCHEMA_BINDING_PATCH",
> +			     "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> +		}
> +

As this already seems to be git dependent, perhaps
it's easier to read with a single line test like:

		if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
			etc...
		}

There are ~3500 existing .txt files:

$ git ls-files -- 'Documentation/devicetree/bindings/*.txt' | wc -l
3476

Are these going to be converted somehow?

What about files like these? (not .txt)

Documentation/devicetree/bindings/timer/st,stih407-lpc
Documentation/devicetree/bindings/nds32/andestech-boards
Documentation/devicetree/bindings/media/nokia,n900-ir
Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
Documentation/devicetree/bindings/arm/arm-boards



