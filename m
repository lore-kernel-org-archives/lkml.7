Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0442147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KsdqdT2w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="njMeDzgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCLJCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:02:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCLJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:02:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6394A608A5; Tue, 12 Mar 2019 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552381320;
        bh=ms/PVSE9pHRSQV9gS52WL4fevOtx3MfMR2UiOgsEQA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KsdqdT2w1Tlu5vT7a3AcOf+PgOfWtCZWveBQuRcnf/eEKDkYlrAwh2obVnw40rGNv
         vgzUr+VKd17YEEK6Sq5sIAWN928emEfGe5I3ngDlYRzgGHpRQcbUBGGIQoy9fIN4RD
         2ISQ1wrv/JsX7Rjjzi5VjwFKqIzjTIyL1jAtsnms=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 874796028D;
        Tue, 12 Mar 2019 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552381319;
        bh=ms/PVSE9pHRSQV9gS52WL4fevOtx3MfMR2UiOgsEQA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=njMeDzgLd5/+v5ksOYTFGgmvCJ2aRRhx9uCg5IftULU+0IQyLynvyVOSejH6CJErJ
         dQnngN6y82MDusDig+XtgYzr4N50myUyYDzsP5AlSf2qDd7zKFk5BYW5TjPdScTgxm
         1oeWMneTi8F7TqcZuT5JBr1nGFJKCW0Bw011fHgc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Mar 2019 17:01:59 +0800
From:   rjliao@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86
 platforms.
In-Reply-To: <20190308185232.GB69116@google.com>
References: <20190307101722.25871-1-bgodavar@codeaurora.org>
 <20190307204224.GD138592@google.com>
 <6e0abe10b3ed44053e92ad6a21c75d93@codeaurora.org>
 <20190308185232.GB69116@google.com>
Message-ID: <1042d21dde881e886541d32b8f0dff63@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-03-09 02:52，Matthias Kaehlcke 写道：
> On Fri, Mar 08, 2019 at 10:43:14AM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2019-03-08 02:12, Matthias Kaehlcke wrote:
>> > Hi Balakrishna,
>> >
>> > On Thu, Mar 07, 2019 at 03:47:22PM +0530, Balakrishna Godavarthi wrote:
>> > > When using btattach to setup Rome over ldisc we observed a crash
>> > > in qca_setup as it will try to access the serdev which is not
>> > > available in the ldisc proto. This patch will fix the crash by
>> > > support both the ldisc and serdev way in the qca hci_uart driver.
>> > >
>> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> >
>> > Oh, I wasn't aware of the instantiation through ldisc and was actually
>> > considering to *remove* some of the seemingly unnecessary serdev
>> > checks.
>> >
>> > > ---
>> > >  drivers/bluetooth/hci_qca.c | 47
>> > > ++++++++++++++++++++++---------------
>> > >  1 file changed, 28 insertions(+), 19 deletions(-)
>> > >
>> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > > index 237aea34b69f..0a5c98d46864 100644
>> > > --- a/drivers/bluetooth/hci_qca.c
>> > > +++ b/drivers/bluetooth/hci_qca.c
>> > > @@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev
>> > > *hdev, uint8_t baudrate)
>> > >  {
>> > >  	struct hci_uart *hu = hci_get_drvdata(hdev);
>> > >  	struct qca_data *qca = hu->priv;
>> > > -	struct qca_serdev *qcadev;
>> > > +	struct qca_serdev *qcadev = NULL;
>> >
>> > In many cases the only field that is accessed is qcadev->btsoc_type. I
>> > think something like 'qca_get_soc_type(struct hci_dev *hdev / struct
>> > hci_uart *hu)' would make things more readable.
>> >
>> [Bala]: sure will update this in other patch once this change is 
>> landed as
>> this has to
>>         go in priority as we have crash coming.
> 
> That's not how things should work, especially for fairly trivial
> changes. It requires reviewers to first spent time to review the patch
> that adds clutter and later spend more time to review the one that
> removes it. It's also easier to get a clean patch merged in the first
> place, rather than a noisy one.
> 
> Anyway, here is my take at it: 
> https://lore.kernel.org/patchwork/patch/1049014/
> 
> Please help with testing for ROME, unless you disagree with the
> approach.
> 
> Thanks
> 
> Matthias

Hi Matthias,

I will test your patch and update to you, and you are correct that 
AR3002 is not part of Rome family, you should use QCA_ROME as the 
default return of qca_soc_type. Could you also loop me in 
https://lore.kernel.org/patchwork/patch/1049014/?

Thanks,
Rocky
