Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB0C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5020825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gUgZo1MM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="COh6Krjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfDOP4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:56:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A793614DB; Mon, 15 Apr 2019 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555343807;
        bh=OBCfH08YP/6ifTZ/b/I14A2w4hOfJJme5YkF9bsvM64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUgZo1MMNIu1hQDFkNZbGupZsKC4FJ4PVH1PYJrMc/AkW6ka7iyazCq/i/uapUMfe
         VqtRpkmEuW5elB7lT6+VrMZSemTUjcVGnTRbHHbblTZOXqbl++O12CzM5e84NkwTRQ
         1Y5hXgs/Gh15HU6uB26RcYu/R7jz0hr9QMsnN9bc=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CD7261197;
        Mon, 15 Apr 2019 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555343806;
        bh=OBCfH08YP/6ifTZ/b/I14A2w4hOfJJme5YkF9bsvM64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COh6KrjwOrmH8H/Y60ae5GquVHQ2r5LS+4p24eTfIAeEE8tIZiiWvnPlGgvbLbD2t
         Qw9UdynKVmTgl5spOIGY4x6AYFFBoOML4QaTq+iNqYeybrfkkfBM+jDoivZqmvdGHh
         0hBS9JpsmypGFlJHzlrjxw/37XNxsqDEpPOF+RRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CD7261197
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 15 Apr 2019 09:56:45 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 00/10] support wakeup capable GPIOs
Message-ID: <20190415155645.GA16124@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <d0ef548a-6721-056b-4394-6e5658b32880@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d0ef548a-6721-056b-4394-6e5658b32880@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2019 at 06:43 -0600, Marc Zyngier wrote:
>On 13/03/2019 21:18, Lina Iyer wrote:
>> Hi all,
>>
>> This series adds support for wakeup capable GPIOs. It is based on Thierry's
>> hiearchical GPIO domains. This approach is based on Stephen's idea [1]. The SoC
>> that is used for this development is a QCOM SDM845. The current patchset is
>> rebased on top of 5.0 and adds documentation for the wakeup-parent and
>> irqdomain-map DT properties along with the the optional irqdomain-map-mask and
>> irqdomain-map-pass-thru properties. Also incorporating comments from Marc on
>> the earlier submission [2]. I cleaned up some of the change history in these
>> patches to match the version number with that of the submission.
>>
>> The dtsi patches are based on Bjorn's changes for increased address and cell
>> size [3] and [4].
>>
>> Kindly review the series.
>
>What the status of this? What is the expected merge strategy?
>
Hi Mark,

I ran into a couple of issues, most of which have been sorted out. But
there is a hardware requirement to write up another register (to set
type), for GPIO wakeup that was missed earlier. I am trying to get that
tested out. That's the hold up. Sorry about that.

--Lina
