Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBBDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693472071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4mLBoSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:27:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44752 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKRU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:27:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so15661015qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rn9PmXG9zN7JtIt5zr+2mmeEEUnpYr+Jpitib9nTCsw=;
        b=v4mLBoSymbGVEY1PIxQQ/QnlTxxm05B1sFyx2xM4xpn3XGoXHrCEf/wR4JBQJO0kCe
         TVyzSxhfdrNQPDeZ8D8ZhZZXvu0TZSaDHcLaINTDIWekINXmEnmavogvIc3PTAl84L+b
         2buhVoL2TmTs7XoEC08/z8dh7xXa8ms0xrcdpOxnzSC4NdxaZomM4u8aGZ92Gy8d4un+
         /X5osXDb2GXDiQewBy+OYiLHANMzip5COZ8B2Tf87Vb2mVx66J6Vovi75TXAVWRCxeYo
         zldpVYYAYa9YkQ2/AsmgAklR1hcebRFlENzey/vREbW4SNCUFJ85c6IfcuSdQi4fy3D5
         WmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rn9PmXG9zN7JtIt5zr+2mmeEEUnpYr+Jpitib9nTCsw=;
        b=jXUCT7bTnAF+s096KsAEP1hfScdNeMxMrNVsp5Qtmk1ZA1bVZbXae8HghZAajl1Kew
         StvoqrIsK6I+zor94QUpVfkNj0U9Q4TaJofsdoyEmAbU4XC67kU2t+/pQMXRJBW2GrUS
         9RXQimglQZIfCQxNWl1SJ9QL542+1nv9vn2ooaXzHWa+0eQ7+DUXK3+QpHE4rUPelJ0x
         +4x+ndGmagAHNyQeiDauVC+oYcXMgSCps6y5ZAxqHrswBd/J9D1MaKxwJnna1Cu0EsRQ
         OMMA/lWui4kcbnv3J7mcXRfluUKzKr1CQEwnIOKpggshG56VitoVmsqwQqhdmeeEMufo
         8T8w==
X-Gm-Message-State: APjAAAWgkv4RgHwxTMOAksW4AGgOdAaxbRsYBzIZqXKc7UK29Ka/8x2g
        zcJaNa6yhKLnB91WQWZGwusZzw==
X-Google-Smtp-Source: APXvYqx3HsIfki1VMmbtrCmd4+45VkEtLaz5aeosbRXeE3EB02qW4CX31/BYAhEdNtRzinswvuYd6A==
X-Received: by 2002:a37:4906:: with SMTP id w6mr14513952qka.82.1574108834507;
        Mon, 18 Nov 2019 12:27:14 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id t27sm9004534qkm.19.2019.11.18.12.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 12:27:13 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:27:12 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeremy Cline <jcline@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.9 02/31] Bluetooth: hci_ldisc: Postpone
 HCI_UART_PROTO_READY bit set in hci_uart_set_proto()
Message-ID: <20191118202712.GA14832@maple.netwinder.org>
References: <20191115062009.813108457@linuxfoundation.org>
 <20191115062010.682028342@linuxfoundation.org>
 <20191115161029.GA32365@maple.netwinder.org>
 <20191116075614.GB381281@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191116075614.GB381281@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 03:56:14PM +0800, Greg Kroah-Hartman wrote:
>>
>> BTW, this also seems to be missing from 4.4 branch, although it was merged
>> for 3.16 (per https://lore.kernel.org/stable/?q=Postpone+HCI).
>
>Odd that it was merged into 3.16, perhaps it was done there because some
>earlier patch added the problem?

This patch should really be viewed as a correction to an earlier commit:
84cb3df02aea ("Bluetooth: hci_ldisc: Fix null pointer derefence in case 
of early data"). This was merged 2016-Apr-08 into v4.7, and therefore is 
included in 4.9 and higher.

Only very recently, on 2019-Sep-23, this was backported to 3.16, along 
with the correction. Both appeared in v3.16.74.

> I say this as I do not think this is
>relevant for the 4.4.y kernel, do you?  Have you tried to apply this
>patch there?

The patch does not apply, but this is mainly due to the earlier commit 
missing. It seems to me like that earlier fix is desirable (and it was 
put into 3.16), along with the followup. So I would think we want it in 
4.4 as well.

[Aside: I'm really only interested in 4.9 and 4.19, so the 4.4 stuff is 
just a diversion. But figured I might as well mention what I found...]

Regards,
-Ralph
