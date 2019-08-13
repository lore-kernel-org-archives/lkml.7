Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EF2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHMIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfHMIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:14:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AA8AAC10;
        Tue, 13 Aug 2019 08:14:57 +0000 (UTC)
Message-ID: <1565684094.7043.3.camel@suse.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
From:   Oliver Neukum <oneukum@suse.com>
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
Cc:     gustavo@embeddedor.com, Jiri Slaby <jirislaby@gmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 13 Aug 2019 10:14:54 +0200
In-Reply-To: <20190813042649.888-1-hdanton@sina.com>
References: <CAAeHK+z-uCr-bWu9uVDynU2S=wCrtxRbuA-Cut=h5zYuYcS-Cw@mail.gmail.com>
         <20190813042649.888-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 13.08.2019, 12:26 +0800 schrieb Hillf Danton:
> [respin with the mess in Cc list cleaned up]

> Followup of commit e3e14de50dff ("HID: fix start/stop cycle in usbhid driver")
> 
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1214,6 +1214,8 @@ static void usbhid_stop(struct hid_devic
>  
>  	hid->claimed = 0;
>  
> +	if (!usbhid->urbin) /* freeing buffers only once */
> +		return;
>  	usb_free_urb(usbhid->urbin);
>  	usb_free_urb(usbhid->urbctrl);
>  	usb_free_urb(usbhid->urbout);

This looks rather suspicious. Why is stop() called multiple times?
Do we have a refcounting issue? If not, what controls locking?

	Regards
		Oliver

