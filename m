Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D65AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378CD2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cmD2jfPX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OPbRYW3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfCKW0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfCKW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:26:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E883760736; Mon, 11 Mar 2019 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552343206;
        bh=xmNjR6cH8wNjIqzf1BfQMDcg4qKA5Qk56ANyyZVdb7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmD2jfPXubErcFVvWVftkVmY8smqlN891+2+sp884kZrf7/Jvt+0tAkxLIqxlfKrJ
         4oFNwrkz7203tnXeMesoVNzEwv8D3gRuycCPmWh71p6YMCfXh67wkC91AEjbfAGbD9
         K5FDgl2D0KIduorJKzAChq1nB/3c8uFFtcIjUxAQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DE6D60736;
        Mon, 11 Mar 2019 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552343205;
        bh=xmNjR6cH8wNjIqzf1BfQMDcg4qKA5Qk56ANyyZVdb7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPbRYW3DSJUs5DkDeeP+IZg6TP1ikZC+49SA0XvosULLr06XmOulh2Py/0wG2rPy9
         bkp2EL3tPT5iW4bn8+MtVbgh/5UAuFwdk7BvMYxbv/vtKue6McSdLfe3/k4HZBV73/
         jLl22A2+25H6MGacHvZiIVlTm+kuAisTyKikpZVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DE6D60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 11 Mar 2019 16:26:43 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 0/9] qcom: support wakeup capable GPIOs
Message-ID: <20190311222643.GA8553@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <3abee3a0-ddde-def9-dd96-5388517e85db@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3abee3a0-ddde-def9-dd96-5388517e85db@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11 2019 at 05:09 -0600, Marc Zyngier wrote:
>On 22/02/2019 22:18, Lina Iyer wrote:
>> Hi all,
>>
>> This series is based on idea of setting up a wakeup parent interrupt controller
>> for GPIOs that are wakeup capable. The patch is based on Thierry's hierarchical
>> GPIO irqdomains. Much of the idea stem's from Stephen's suggestions in [1] with
>> some fixes.
>
>Given how long it took to get there, I'm really keen on moving forward
>with this as the first implementation. There is a number of things that
>needs fixing, but nothing that looks major so far.
>
>> I am posting this series to help with the discussions around this approach.
>> Please take a look at the series and let me know your comments. We need to find
>> a good place to add the document the generic irqdomain-map bindings.
>
>How about the obvious
>Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.
>
>I'd really like to see a respin of this by -rc1.
>
Thanks for the review Marc. Will do a respin in a couple of days.

Thanks,
Lina
