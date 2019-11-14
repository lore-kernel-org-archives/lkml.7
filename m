Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D22206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ynzd2vfH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ynzd2vfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKNPVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:21:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKNPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:21:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8554960877; Thu, 14 Nov 2019 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744897;
        bh=PU3yZVOeBpzkLQjkHpVff7IXxNz5VK8V0mZiVHhrJ+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ynzd2vfH9jrfwrTeOQIoSzZVBdX2DCXId0z013j5byO9yhxEEYxqU0MThLTrjN+C6
         N0sHZxAG4QFS57Hg5eIlP1JS0n3A9UyEWXYYJeuE8/jbzAF5U/KenjY2sg0GenAi7M
         V8cDgCxfYjsfBhO/AeDCd21AlCcSPYyPIbApj9zw=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEEE4601B4;
        Thu, 14 Nov 2019 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744897;
        bh=PU3yZVOeBpzkLQjkHpVff7IXxNz5VK8V0mZiVHhrJ+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ynzd2vfH9jrfwrTeOQIoSzZVBdX2DCXId0z013j5byO9yhxEEYxqU0MThLTrjN+C6
         N0sHZxAG4QFS57Hg5eIlP1JS0n3A9UyEWXYYJeuE8/jbzAF5U/KenjY2sg0GenAi7M
         V8cDgCxfYjsfBhO/AeDCd21AlCcSPYyPIbApj9zw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEEE4601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] dt-bindings: Improve validation build error handling
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20191113210544.1894-1-robh@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <30b73f89-1ba1-6052-53bd-414ebdfa142c@codeaurora.org>
Date:   Thu, 14 Nov 2019 08:21:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113210544.1894-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2019 2:05 PM, Rob Herring wrote:
> Schema errors can cause make to exit before useful information is
> printed. This leaves developers wondering what's wrong. It can be
> overcome passing '-k' to make, but that's not an obvious solution.
> There's 2 scenarios where this happens.
> 
> When using DT_SCHEMA_FILES to validate with a single schema, any error
> in the schema results in processed-schema.yaml being empty causing a
> make error. The result is the specific errors in the schema are never
> shown because processed-schema.yaml is the first target built. Simply
> making processed-schema.yaml last in extra-y ensures the full schema
> validation with detailed error messages happen first.
> 
> The 2nd problem is while schema errors are ignored for
> processed-schema.yaml, full validation of the schema still runs in
> parallel and any schema validation errors will still stop the build when
> running validation of dts files. The fix is to not add the schema
> examples to extra-y in this case. This means 'dtbs_check' is no longer a
> superset of 'dt_binding_check'. Update the documentation to make this
> clear.
> 
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

I injected a syntax error into a random binding file, and compared the 
output with and without this patch.  This patch makes a massive 
improvement in giving the user the necessary information to identify and 
fix issues.  Thanks!

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

> ---
>   Documentation/devicetree/bindings/Makefile  | 5 ++++-
>   Documentation/devicetree/writing-schema.rst | 6 ++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 5138a2f6232a..646cb3525373 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -12,7 +12,6 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
>   	$(call if_changed,chk_binding)
>   
>   DT_TMP_SCHEMA := processed-schema.yaml
> -extra-y += $(DT_TMP_SCHEMA)
>   
>   quiet_cmd_mk_schema = SCHEMA  $@
>         cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> @@ -26,8 +25,12 @@ DT_DOCS = $(shell \
>   
>   DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
>   
> +ifeq ($(CHECK_DTBS),)
>   extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
>   extra-y += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
> +endif
>   
>   $(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
>   	$(call if_changed,mk_schema)
> +
> +extra-y += $(DT_TMP_SCHEMA)
> diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
> index 3fce61cfd649..efcd5d21dc2b 100644
> --- a/Documentation/devicetree/writing-schema.rst
> +++ b/Documentation/devicetree/writing-schema.rst
> @@ -133,11 +133,13 @@ binding schema. All of the DT binding documents can be validated using the
>   
>       make dt_binding_check
>   
> -In order to perform validation of DT source files, use the `dtbs_check` target::
> +In order to perform validation of DT source files, use the ``dtbs_check`` target::
>   
>       make dtbs_check
>   
> -This will first run the `dt_binding_check` which generates the processed schema.
> +Note that ``dtbs_check`` will skip any binding schema files with errors. It is
> +necessary to use ``dt_binding_check`` to get all the validation errors in the
> +binding schema files.
>   
>   It is also possible to run checks with a single schema file by setting the
>   ``DT_SCHEMA_FILES`` variable to a specific schema file.
> 


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
