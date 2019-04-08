Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09F8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83BA20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDHKmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:42:43 -0400
Received: from foss.arm.com ([217.140.101.70]:46120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfDHKml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:42:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E1315AD;
        Mon,  8 Apr 2019 03:42:41 -0700 (PDT)
Received: from [10.37.12.66] (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050D43F718;
        Mon,  8 Apr 2019 03:42:38 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        shiwanglai@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406112145.15184-1-leo.yan@linaro.org>
 <20190406112145.15184-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b661edd2-5b99-f8f7-b5a5-8e4497043087@arm.com>
Date:   Mon, 8 Apr 2019 11:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190406112145.15184-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2019 12:21 PM, Leo Yan wrote:
> CoreSight uses below bindings for replicator:
> 
>    Static replicator, aka. non-configurable replicator:
>      "arm,coresight-replicator";
> 
>    Dynamic replicator, aka. configurable replicator:
>      "arm,coresight-dynamic-replicator", "arm,primecell";
> 
> The compatible string "arm,coresight-replicator" is not an explicit
> naming to express the replicator is 'static'.  To unify the naming
> convention, this patch introduces a new compatible string
> "arm,coresight-static-replicator" for the static replicator; the
> compatible string "arm,coresight-replicator" is still kept thus we
> can support the old DT binding, but tag it as obsolete and suggest
> to use the new compatible string.
> 
> As result CoreSight replicator have below bindings:
> 
>    Static replicator:
>      "arm,coresight-replicator"; (obsolete)
>      "arm,coresight-static-replicator";
> 
>    Dynamic replicator:
>      "arm,coresight-dynamic-replicator", "arm,primecell";
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/coresight.txt | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index f8aff65ab921..f8f794869af2 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -69,7 +69,11 @@ its hardware characteristcs.
>   
>   	* compatible: Currently supported value is (note the absence of the
>   	  AMBA markee):
> -		- "arm,coresight-replicator"
> +		- Coresight Non-configurable Replicator, the compatible string
> +		  "arm,coresight-replicator" is obsolete, keep it to support

To make it more obvious : s/obsolete/OBSOLETE/

> +		  the old DT bindings:
> +			"arm,coresight-replicator";
> +			"arm,coresight-static-replicator";

nit: I would re-order the compatible strings to show the precedence of
choice.

e.g,
	- CoreSight non-configurable Replicator
		"arm,coresight-static-replicator";
		"arm,coresight-replicator"; (OBSOLETE. For
			backward compatibility. Will be removed )


Also, please could we put a warning in the driver when we encounter it
and request to update it ?

Cheers
Suzuki
