Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E55C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1448B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="z6EGNFck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZSQ3rIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfJHD45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:56:57 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40935 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729772AbfJHD45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:56:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E8A4D4A0;
        Mon,  7 Oct 2019 23:56:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Oct 2019 23:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=R
        xsn7iMWp8Vi3LI57d1xviBs21qUtsYxviHnhDffXis=; b=z6EGNFck4JOxbhpSK
        F9sF04qSCYUrCS17sOGNPgnUqQAsijEd2BCZ8OOyuMctfYrhHJi5jpFFTnoOw89Y
        RkHjdfHQoWJTkGLRBcuD+JIMxCxkWY6SQZLtjpMg559HBkVHKlWUbWwpuh/ZJQPJ
        49i+jrOXvN62PjuvUbGt5enY2FjQ1BtNu7QVvDp4iBrlSMQJRWjsvcdCXb1uzAMJ
        Av2oMMnmgzQ9ASrNmI9k/7XF4kIU3Hdem8VV7Hw9dsah+X+oTOcC6zFJD264zFHQ
        YoNvPj7OYRJqHOB62rbAI3Tl6I1ECOzkNKhiRDe6+V13VpqjUR2lCRy0+N6PN7Iu
        Iyteg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Rxsn7iMWp8Vi3LI57d1xviBs21qUtsYxviHnhDffX
        is=; b=ZZSQ3rINi1rsN23Gwggnw7P2SRv0MwuqTMg5hv037YmxRQ7abfFzZehUu
        NPcRPxTVrDY7dJq2GYqtObi/Z7mrU+4liHfBt23qtulGTaru0Ra5mEuq7xQlb2wM
        JLqjKjOK7rZ077dNg7zhU3HApGZm5Lt94veK903Q7QNcYRF/XEii9DqtzmuuaVWU
        kPUbLXFJsy214z+3K4a7ga7ReXTfgP8tG5s+h5IMZyfHFsIQfT7ncvkZlKag60O5
        QdAhffG3hK6NoRFYPqhk8PmBtnwK9jlRVwUjbu4jnquvy3GADdU+ybgouhx1Elgh
        +96O35EXhAmgVgLo/muX/VzAkxBOA==
X-ME-Sender: <xms:BQmcXTZhVTrMO8WxRwGypnw9aeQbG2AxvRp2XJJn1QEIl7f2tj0reg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefuvfhfhffkffgfgggjtgfg
    sehtjeertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuh
    gvlhesshhhohhllhgrnhgurdhorhhgqeenucffohhmrghinhepghhoohhglhgvrdgtohhm
    necukfhppeejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:BQmcXevUI78Tlbv-ug7miuqTr_n27kbaBrkh6dZpDtwxpUBVD74UPQ>
    <xmx:BQmcXYvTL7VU9osWQ5OHn7_AWGHN8yH2jvmdX83z0qinZ92PjW9hjw>
    <xmx:BQmcXbeTI4Qt-lw9jij0VtaT9auPJ7jMD4kBqEAlIdo6sRjWxY_7UA>
    <xmx:BwmcXWSvXUhwpnN6mRKQxhu696MrppIEKnOoMPbpmjNmFzOjPDyn2g>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64AD380060;
        Mon,  7 Oct 2019 23:56:53 -0400 (EDT)
Subject: Re: [linux-sunxi] [PATCH] bus: sunxi-rsb: Make interrupt handling
 more robust
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>
Cc:     Stephen Boyd <sboyd@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20190824175013.28840-1-samuel@sholland.org>
 <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3b555db6-4e8a-ab0f-61b6-dad97421b652@sholland.org>
Date:   Mon, 7 Oct 2019 22:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 10:19 AM, Chen-Yu Tsai wrote:
> On Sun, Aug 25, 2019 at 1:50 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> The RSB controller has two registers for controlling interrupt inputs:
>> RSB_INTE, which has bits for each possible interrupt, and the global
>> interrupt enable bit in RSB_CTRL.
>>
>> Currently, we enable the bits in RSB_INTE before each transfer, but this
>> is unnecessary because we never disable them. Move the initialization of
>> RSB_INTE so it is done only once.
>>
>> We also set the global interrupt enable bit before each transfer. Unlike
>> other bits in RSB_CTRL, this bit is cleared by writing a zero. Thus, we
>> clear the bit in the post-timeout cleanup code, so note that in the
>> comment.
>>
>> However, if we do receive an interrupt, we do not clear the bit. Nor do
>> we clear interrupt statuses before starting a transfer. Thus, if some
>> other driver uses the RSB bus while Linux is suspended (as both Trusted
>> Firmware and SCP firmware do to control the PMIC), we receive spurious
>> interrupts upon resume. This causes false completion of a transfer, and
>> the next transfer starts prematurely, causing a LOAD_BSY condition. The
>> end result is that some transfers at resume fail with -EBUSY.
> 
> If we are expecting the hardware to not be in the state we assume to be
> or left it in, then maybe we should also keep setting the interrupt enable
> bits on each transfer?
> 
> Surely we expect to have exclusive use of the controller most of the time.
> If it's to handle suspend/resume, shouldn't we be adding power management
> callbacks instead? That would reset the controller to a known state when
> the system comes out of suspend, including clearing any pending interrupts.

Yes, this change is only to handle suspend/resume. You're right, that's a better
way to do it. I'll develop a patch using device power management callbacks.

Samuel

> Maxime, anything you want to add? (BTW, Maxime switched email addresses.)
> 
> ChenYu
> 
>> With this patch, all transfers reliably succeed during/after resume.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/bus/sunxi-rsb.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>> index be79d6c6a4e4..b8043b58568a 100644
>> --- a/drivers/bus/sunxi-rsb.c
>> +++ b/drivers/bus/sunxi-rsb.c
>> @@ -274,7 +274,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>>         reinit_completion(&rsb->complete);
>>
>>         writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
>> -              rsb->regs + RSB_INTE);
>> +              rsb->regs + RSB_INTS);
>>         writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>>                rsb->regs + RSB_CTRL);
>>
>> @@ -282,7 +282,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>>                                             msecs_to_jiffies(100))) {
>>                 dev_dbg(rsb->dev, "RSB timeout\n");
>>
>> -               /* abort the transfer */
>> +               /* abort the transfer and disable interrupts */
>>                 writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
>>
>>                 /* clear any interrupt flags */
>> @@ -480,6 +480,9 @@ static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
>>         status = readl(rsb->regs + RSB_INTS);
>>         rsb->status = status;
>>
>> +       /* Disable any further interrupts */
>> +       writel(0, rsb->regs + RSB_CTRL);
>> +
>>         /* Clear interrupts */
>>         status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
>>                    RSB_INTS_TRANS_OVER);
>> @@ -718,6 +721,9 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
>>                 goto err_reset_assert;
>>         }
>>
>> +       writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
>> +              rsb->regs + RSB_INTE);
>> +
>>         /* initialize all devices on the bus into RSB mode */
>>         ret = sunxi_rsb_init_device_mode(rsb);
>>         if (ret)
>> --
>> 2.21.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190824175013.28840-1-samuel%40sholland.org.

