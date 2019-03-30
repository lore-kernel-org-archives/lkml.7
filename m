Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6264EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3420989
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4UE83rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfC3WhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:37:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39964 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfC3WhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 18:37:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so4991144edw.7;
        Sat, 30 Mar 2019 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pK3plyBmjAV4xHZUQyKdGxR9hXUzh16No6voNcD6UPQ=;
        b=U4UE83rnFvQfvT+VbJeqdJRGi9/uOCz1Em4L7EqZDuPNZgTOnM7xg2hC4CUfBLe/Hb
         Ey0Ek+4YSTBO/L3e543W75+r68JZ0E18vHsOxdES9e7hLXygHTua60Mo0xC2kHM4U4fa
         JRArOFk9scFPQ39UlQUFpPN0fk7YOV8ieQD5KwegVYjt31idE9bw81th0DIIO+n5HCwQ
         68krMqrzAO+Sn+3q8UjUTrBomvAdWlaeL9m6o/Ngvs6jqQ66HB/m9mANVonezV782fsf
         gF+2qey8SNdvBys3Y6591GJ2akvcil4MRv9Oub0HnDO/QOwBiqsOgTcGNWn1/kNx1BG7
         ZgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pK3plyBmjAV4xHZUQyKdGxR9hXUzh16No6voNcD6UPQ=;
        b=Dm3ymcT9qhh43CQeMklTOuOVXQYpvNkX/0Rp93IhvIRqFU7vOuo9sFeFt7VtCFxN/S
         awbjk5nQAifIlPVJedbec/J1ocxJgru03A4z8sO6P/A5PWMkVvIraRQblN4V3uL/KJHn
         tdhMiCSTPaYLEp4pDk/VhUqK5ttOVa4761wRNt6GBHeOebYGzRgPSHVCjW4sSJJW0g8t
         /ugFVwfNeDqUbsQcoKVPedl8WpTh8IR0u6rkbodyyefBJ/uFfFgbwtaLwczYpOYGCkPp
         rhU4JNTkwUDTNwyLNu5uAyfGI+ZD+I7/QgaZkYalTBQ0pJmgYZpj0tLMVZwPdF4mCXrF
         SW2w==
X-Gm-Message-State: APjAAAUrWWfHnrVa39zyppQUDAhYm+Zy2PFYuE7WUQr3OXnPo+CYJfBW
        +MDd9aGU5sQ/m0wwS6NM6Wg=
X-Google-Smtp-Source: APXvYqwpxBdaOB3ibILa8ZpcsHR0wyXBOtZMpUAZRGcRkVJRNMB2qYb6vWk1Q9KrA2A/3PDqz4yNew==
X-Received: by 2002:a50:97d0:: with SMTP id f16mr35619709edb.287.1553985441257;
        Sat, 30 Mar 2019 15:37:21 -0700 (PDT)
Received: from [192.168.0.61] (xd520f242.cust.hiper.dk. [213.32.242.66])
        by smtp.gmail.com with ESMTPSA id g27sm1817009edg.77.2019.03.30.15.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:37:20 -0700 (PDT)
Subject: Re: [PATCH] net/bluetooth: Fix bound check in event handling
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20190330071757.GU32613@kadam>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ede5be42-1113-3873-208b-ca46bee922c3@gmail.com>
Date:   Sat, 30 Mar 2019 23:37:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190330071757.GU32613@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 3/30/19 8:17 AM, Dan Carpenter wrote:
> [ This is an old warning.  Sorry for missing it earlier.  I would have
>   caught it when the code was merged as well so there was no real risk
>   but it's just awkward.  ]
> 
> Hi Tomas,
> 
> url:    https://github.com/0day-ci/linux/commits/Tomas-Bortoli/net-bluetooth-Fix-bound-check-in-event-handling/20190301-213647
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> 
> smatch warnings:
> net/bluetooth/hci_event.c:3986 hci_inquiry_result_with_rssi_evt() warn: potential pointer math issue ('info' is a 120 bit pointer)
> 
> # https://github.com/0day-ci/linux/commit/00305742c021794f147b348d45eb10ea26e5a514
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 00305742c021794f147b348d45eb10ea26e5a514
> vim +3986 net/bluetooth/hci_event.c
> 
> 6039aa73 Gustavo Padovan 2012-05-23  3963  static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
> 807deac2 Gustavo Padovan 2012-05-17  3964  					     struct sk_buff *skb)
> a9de9248 Marcel Holtmann 2007-10-20  3965  {
> a9de9248 Marcel Holtmann 2007-10-20  3966  	struct inquiry_data data;
> a9de9248 Marcel Holtmann 2007-10-20  3967  	int num_rsp = *((__u8 *) skb->data);
> a9de9248 Marcel Holtmann 2007-10-20  3968  
> a9de9248 Marcel Holtmann 2007-10-20  3969  	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
> a9de9248 Marcel Holtmann 2007-10-20  3970  
> a9de9248 Marcel Holtmann 2007-10-20  3971  	if (!num_rsp)
> a9de9248 Marcel Holtmann 2007-10-20  3972  		return;
> a9de9248 Marcel Holtmann 2007-10-20  3973  
> d7a5a11d Marcel Holtmann 2015-03-13  3974  	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
> 1519cc17 Andre Guedes    2012-03-21  3975  		return;
> 1519cc17 Andre Guedes    2012-03-21  3976  
> a9de9248 Marcel Holtmann 2007-10-20  3977  	hci_dev_lock(hdev);
> a9de9248 Marcel Holtmann 2007-10-20  3978  
> a9de9248 Marcel Holtmann 2007-10-20  3979  	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
> 138d22ef Szymon Janc     2011-02-17  3980  		struct inquiry_info_with_rssi_and_pscan_mode *info;
> 138d22ef Szymon Janc     2011-02-17  3981  		info = (void *) (skb->data + 1);
> a9de9248 Marcel Holtmann 2007-10-20  3982  
> e17acd40 Johan Hedberg   2011-03-30  3983  		for (; num_rsp; num_rsp--, info++) {
> af58925c Marcel Holtmann 2014-07-01  3984  			u32 flags;
> af58925c Marcel Holtmann 2014-07-01  3985  
> 00305742 Tomas Bortoli   2019-02-28 @3986  			if ((void *)(info + sizeof(info)) >
>                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should be (void *)info + sizeof(info).  The code you have will
> break for valid uses because the pointer math error.  I notice that
> this isn't merged into linux-next, but it does seem required.  I am
> writing a similar fix for a different function.
> 
> Another way to write this would be:
> 
> 		if ((u8 *)(info + 1) > &skb->data[skb->len]) {

Yeah it hasn't been accepted afaik. Why just + 1 ? Also,
&skb->data[skb->len] is right after the last byte so the > should rather
be a >=, I think.

your code looks better (as per pointer casting) but is logically
different from what I proposed with v2:

https://lkml.org/lkml/2019/3/4/892

I think the bound check should validate that there is enough data from
the info pointer to read an entire struct
inquiry_info_with_rssi_and_pscan_mode.

Best regards,
Tomas

