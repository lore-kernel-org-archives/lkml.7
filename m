Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782EDC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453E3218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PHnDSrVD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YkMHRIYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGCAmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:42:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:42:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D5D66025A; Wed,  3 Jul 2019 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562112231;
        bh=Ehzb5REbZ1sAGqR0DY72rQI/Hyw2RX9/t1g57kj00rs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PHnDSrVDwfgQJgf0I+W+KiUM86AS4rE6Fy2Av270knbxo+bEBYplTz/ZCPQuEe2I4
         fNzPDwaSZmBiKo5VrP0sRQRLEYzURkM4UWHUZJhyn8FZwrHSNghuSX7UHfV8XAd558
         BbrAULrw8EBM7HOh+AHyh++3rcGV3X4HoXZMpYAc=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 257F66025A;
        Wed,  3 Jul 2019 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562112230;
        bh=Ehzb5REbZ1sAGqR0DY72rQI/Hyw2RX9/t1g57kj00rs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YkMHRIYLA5V46KlIhru4A3fnsbCSkndtSW9zs2Cjaim0N2J64OYjzq8THiO9uc63G
         pjPnWHJwm0B583nkQzsUveSzVv0Jwe2j5cWQBRKv6eBvXzKhEPU3zEIbNuGVe7J29W
         0dOSvKmHAXUZVMS609/mKWBo3oXa1snC9A6dFOjs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 257F66025A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 0/4] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190702004811.136450-1-saravanak@google.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <7900c670-5b3a-f950-dec9-70d98d94a84f@codeaurora.org>
Date:   Tue, 2 Jul 2019 17:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190702004811.136450-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

On 7/1/19 5:48 PM, Saravana Kannan wrote:
...
> TODO:
> - For the case of consumer child sub-nodes being added by a parent
>   device after late_initcall_sync we might be able to address that by
>   recursively parsing all child nodes and adding all their suppliers as
>   suppliers of the parent node too. The parent probe will add the
>   children before its probe is completed and that will prevent the
>   supplier's sync_state from being executed before the children are
>   probed.
> 
> But I'll write that part once I see how this series is received.

I don't think that this scheme will work in all cases.  It can also lead
to probing deadlock.

Here is an example:

Three DT devices (top level A with subnodes B and C):
/A
/A/B
/A/C
C is a consumer of B.

When device A is created, a search of its subnodes will find the link from
C to B.  Since device B hasn't been created yet, of_link_to_suppliers()
will fail and add A to the wait_for_suppliers list.  This will cause the
probe of A to fail with -EPROBE_DEFER (thanks to the check in
device_links_check_suppliers()).  As a result device B will not be created
and device A will never probe.

You could try to resolve this situation by detecting the cycle and *not*
adding A to the wait_for_suppliers list.  However, that would get us back
to the problem we had before.  A would be allowed to probe which would
then result in devices being added for B and C.  If the device for B is
added before C, then it would be allowed to immediately probe and
(assuming this all takes place after late_initcall_sync thanks to modules)
its sync_state() callback would be called since no consumer devices are
linked to B.

Please note that to change this example from theoretical to practical,
replace "A" with apps_rsc, "B" with pmi8998-rpmh-regulators, and "C" with
pm8998-rpmh-regulators in [1].

Take care,
David

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845-mtp.dts?h=v5.2-rc7#n55

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
