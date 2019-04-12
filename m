Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704120675
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDLKh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:37:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57738 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLKh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:37:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5EB15AB;
        Fri, 12 Apr 2019 03:37:57 -0700 (PDT)
Received: from [10.37.13.120] (unknown [10.37.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD593F718;
        Fri, 12 Apr 2019 03:37:55 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a38d1f9e-622e-7fd6-6282-be5601863c11@arm.com>
Date:   Fri, 12 Apr 2019 11:40:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190412102738.12679-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 11:27 AM, Leo Yan wrote:
> CoreSight uses below bindings for replicator:
> 
>    Dynamic replicator, aka. configurable replicator:
>      "arm,coresight-dynamic-replicator", "arm,primecell";
> 
>    Static replicator, aka. non-configurable replicator:
>      "arm,coresight-replicator";
> 
> The compatible string "arm,coresight-replicator" is not an explicit
> naming to express the replicator is 'static'.  To unify the naming
> convention, this patch introduces a new compatible string
> "arm,coresight-static-replicator" for the static replicator; the
> compatible string "arm,coresight-replicator" is kept for backward
> compatibility, but tag it as obsolete and suggest to use the new
> compatible string.
> 
> As result CoreSight replicator have below bindings:
> 
>    Dynamic replicator:
>      "arm,coresight-dynamic-replicator", "arm,primecell";
> 
>    Static replicator:
>      "arm,coresight-static-replicator";
>      "arm,coresight-replicator"; (obsolete)
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index f8aff65ab921..d02d160fa8ac 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -69,7 +69,10 @@ its hardware characteristcs.
>   
>   	* compatible: Currently supported value is (note the absence of the
>   	  AMBA markee):
> -		- "arm,coresight-replicator"
> +		- Coresight Non-configurable Replicator:
> +			"arm,coresight-static-replicator";
> +			"arm,coresight-replicator"; (OBSOLETE. For backward
> +				compatibility and will be removed)
>   
>   	* port or ports: see "Graph bindings for Coresight" below.
>   
> @@ -169,7 +172,7 @@ Example:
>   		/* non-configurable replicators don't show up on the
>   		 * AMBA bus.  As such no need to add "arm,primecell".
>   		 */
> -		compatible = "arm,coresight-replicator";
> +		compatible = "arm,coresight-static-replicator";

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
