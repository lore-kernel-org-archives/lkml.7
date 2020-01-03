Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0373AC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FA2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zr9z0+Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgACLvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:51:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53126 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgACLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:51:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200103115147euoutp01673d68bd2bdc8036a792ccce83db7751~mXjaWwLKA1832118321euoutp01K
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:51:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200103115147euoutp01673d68bd2bdc8036a792ccce83db7751~mXjaWwLKA1832118321euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578052308;
        bh=Sgwy2KLcGLPK01nlysDpcA4/9mVkMoaVzwZVwaSsICE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zr9z0+GnpO4ViBITKs6NMqkptq91kA1c8ZRtkO0Wif+ozbLvuPbv9SgKo5sNitidW
         C5QD9+tEwtEhr7Em2n1AJP7EkpIpYV+BJmU8HZM98iW2MS4iSGNpTd5iWINAY7Zrnt
         X5kf4L70nHLMi/8T1ZSJf7gwpyFIeodJ6NMwudC0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103115147eucas1p25609a3769b2613611f7df3c69f306f9e~mXjaD2xAH1655116551eucas1p2_;
        Fri,  3 Jan 2020 11:51:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.84.60679.3DA2F0E5; Fri,  3
        Jan 2020 11:51:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103115147eucas1p1696e114e15f642f7ef17da536a9cdbdc~mXjZrZMbV1451214512eucas1p1X;
        Fri,  3 Jan 2020 11:51:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103115147eusmtrp1ed6334f1acc5a6666e717b21ef840f6a~mXjZqxNyr1010210102eusmtrp1G;
        Fri,  3 Jan 2020 11:51:47 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-b5-5e0f2ad37543
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.32.08375.3DA2F0E5; Fri,  3
        Jan 2020 11:51:47 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103115146eusmtip1486712526aab1c1ec7cc0358755332bd~mXjZOFSP51713417134eusmtip1c;
        Fri,  3 Jan 2020 11:51:46 +0000 (GMT)
Subject: Re: [PATCH v3 1/3] fbdev: fix numbering of fbcon options
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <209fe07a-96d7-98db-7c3b-81a932291bd9@samsung.com>
Date:   Fri, 3 Jan 2020 12:51:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827110854.12574-2-peda@axentia.se>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87qXtfjjDJ6uUbd4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/R4vePOWwOHB7TDsxm99i8Qsvj0OEORo/73ceZ
        PBb3TWb1+LxJLoAtissmJTUnsyy1SN8ugSvjwN7JjAVzBCsOLZnL2MB4k7eLkZNDQsBEYten
        p6xdjFwcQgIrGCW2/53OCJIQEvjCKNHVWwGR+MwocatrByNMx/XW6+wQieWMEn2zG1kgnLeM
        EgcuTAarEhZwlDjzuI8dxBYRUJRYsGsWM0gRs8BPJon+taeYQBJsAlYSE9tXgTXwCthJ/J5y
        lg3EZhFQkZg35QIriC0qECHx6cFhVogaQYmTM58AbePg4BQwlTj/ug4kzCwgLnHryXwmCFte
        YvvbOWC7JASOsUs8evca6mwXicUvDrBC2MISr45vYYewZSROT+5hgWhYxyjxt+MFVPd2Ronl
        k/+xQVRZS9w594sNZDOzgKbE+l36IKYE0JeNf8UgTD6JG28FIW7gk5i0bTozRJhXoqNNCGKG
        msSGZRvYYLZ27VzJPIFRaRaSx2Yh+WYWkm9mIaxdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQv
        XS85P3cTIzApnf53/MsOxl1/kg4xCnAwKvHwJijzxwmxJpYVV+YeYpTgYFYS4S0P5I0T4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgTGk8vZD+X9aS++W
        72OfbjdFuFGDQ+1x/AxtPRHX1Ek/lK4d2PFoymIvO+NNwu/uTtS9+rV0evqcjR9XhrO43K45
        PbHbOex9LefqGdt3SxesnvEqxnDKdccZpsY7n2xY+CiT0c+sbeZnsbN8JkW/Zy7if6Jpdfz+
        zCe+wikruz3nhq0IvHLl9LFTSizFGYmGWsxFxYkAhHQvKEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qXtfjjDJ5/5LZ4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/R4vePOWwOHB7TDsxm99i8Qsvj0OEORo/73ceZ
        PBb3TWb1+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS/jwN7JjAVzBCsOLZnL2MB4k7eLkZNDQsBE4nrrdfYuRi4OIYGljBJvz/9m7GLk
        AErISBxfXwZRIyzx51oXG0TNa0aJ8/3vmUASwgKOEmce97GD2CICihILds1iBiliFvjNJDF9
        4XuoqZsZJXa/b2AGqWITsJKY2L6KEcTmFbCT+D3lLBuIzSKgIjFvygVWEFtUIELi8I5ZUDWC
        EidnPmEBuYhTwFTi/Os6kDCzgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg0C0n3LCQts5C0
        zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgHG479nPzDsZLG4MPMQpwMCrx8CYo
        88cJsSaWFVfmHmKU4GBWEuEtD+SNE+JNSaysSi3Kjy8qzUktPsRoCvTbRGYp0eR8YIrIK4k3
        NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqF/H4TD57i2rkmt6AdM4
        jwc7nQwU373jbHmOx/9FJs9cny1c3OK6iMH6SfXurzICge98ajwt5HLLsnZylS5/kbT10u/c
        sBOdZjNXP+Bu9zlptytd2GrfSjkGixL3iwX/p5zd/qfhdeht7fh3twV+heo9vOUzYWLwob83
        9qTUb+fh1H1fdaj2gxJLcUaioRZzUXEiAAZsiFrZAgAA
X-CMS-MailID: 20200103115147eucas1p1696e114e15f642f7ef17da536a9cdbdc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190827110923epcas1p1ef1052284e2b565746491c0d63a39c1b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190827110923epcas1p1ef1052284e2b565746491c0d63a39c1b
References: <20190827110854.12574-1-peda@axentia.se>
        <CGME20190827110923epcas1p1ef1052284e2b565746491c0d63a39c1b@epcas1p1.samsung.com>
        <20190827110854.12574-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/19 1:09 PM, Peter Rosin wrote:
> Three shall be the number thou shalt count, and the number of the
> counting shall be three. Four shalt thou not count...
> 
> One! Two! Five!
> 
> Fixes: efb985f6b265 ("[PATCH] fbcon: Console Rotation - Add framebuffer console documentation")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/fb/fbcon.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index ebca41785abe..65ba40255137 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -127,7 +127,7 @@ C. Boot options
>  	is typically located on the same video card.  Thus, the consoles that
>  	are controlled by the VGA console will be garbled.
>  
> -4. fbcon=rotate:<n>
> +5. fbcon=rotate:<n>
>  
>  	This option changes the orientation angle of the console display. The
>  	value 'n' accepts the following:
> @@ -152,21 +152,21 @@ C. Boot options
>  	Actually, the underlying fb driver is totally ignorant of console
>  	rotation.
>  
> -5. fbcon=margin:<color>
> +6. fbcon=margin:<color>
>  
>  	This option specifies the color of the margins. The margins are the
>  	leftover area at the right and the bottom of the screen that are not
>  	used by text. By default, this area will be black. The 'color' value
>  	is an integer number that depends on the framebuffer driver being used.
>  
> -6. fbcon=nodefer
> +7. fbcon=nodefer
>  
>  	If the kernel is compiled with deferred fbcon takeover support, normally
>  	the framebuffer contents, left in place by the firmware/bootloader, will
>  	be preserved until there actually is some text is output to the console.
>  	This option causes fbcon to bind immediately to the fbdev device.
>  
> -7. fbcon=logo-pos:<location>
> +8. fbcon=logo-pos:<location>
>  
>  	The only possible 'location' is 'center' (without quotes), and when
>  	given, the bootup logo is moved from the default top-left corner
