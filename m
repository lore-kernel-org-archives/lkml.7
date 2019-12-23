Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C2C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C93A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FqpmAvP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWKvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:51:38 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:28110 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfLWKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:51:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577098296; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TGpdVO4TQrAiEbW35Q+cAOtdIcH3Y8wTeKCax2w3lDk=;
 b=FqpmAvP0JOHL6TmUZoKVM9BptAEGLe8avf1XQ+osDCFQPf3kp7xFU6HNC8m9PPvlgpL2Hnv0
 y3pF+7u3L2SiiwkJgJpyCIO84JwNriiXBwMI+Ix1xaDzLelbtMAFZhOAL0YnVC8vsTqjryCQ
 8Mw4NSlIp+pwa6h52y+S0fAm3n0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e009c36.7f2a6607ae68-smtp-out-n01;
 Mon, 23 Dec 2019 10:51:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D950BC4479C; Mon, 23 Dec 2019 10:51:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sthella)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BB85C43383;
        Mon, 23 Dec 2019 10:51:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Dec 2019 16:21:34 +0530
From:   sthella@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     srinivas.kandagatla@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] nvmem: add QTI SDAM driver
In-Reply-To: <20191220002929.GJ448416@yoga>
References: <1576574432-9649-1-git-send-email-sthella@codeaurora.org>
 <20191218061400.GV3143381@builder>
 <17c718c483db710b32b2dbbcf4637783@codeaurora.org>
 <20191220002929.GJ448416@yoga>
Message-ID: <9d1cd4bdf63fd2ad980554e913c5741a@codeaurora.org>
X-Sender: sthella@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 05:59, Bjorn Andersson wrote:
> On Thu 19 Dec 02:29 PST 2019, sthella@codeaurora.org wrote:
> 
>> On 2019-12-18 11:44, Bjorn Andersson wrote:
>> > On Tue 17 Dec 01:20 PST 2019, Shyam Kumar Thella wrote:
> [..]
>> > > +subsys_initcall(sdam_init);
>> >
>> > module_platform_driver(sdam_driver), unless you have some strong
>> > arguments for why this needs to be subsys_initcall
>> There are some critical sybsystems which depend on nvmem data. So I 
>> would
>> prefer using subsys_initcall().
> 
> How critical? Needed to kernel module loading?
> 
> Can you please document this need somehow? (either a comment here or
> something in the commit message). Be specific.
Sure. I will add the need in commit message in its next patch.
> 
> THanks,
> Bjorn
