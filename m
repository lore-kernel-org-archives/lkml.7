Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2DC208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tknfD4LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfFGMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:33:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41472 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfFGMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:33:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607123312euoutp01cee71aecea9aaae0dddd780d1d6aaaa0~l6pnDbkW60214302143euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607123312euoutp01cee71aecea9aaae0dddd780d1d6aaaa0~l6pnDbkW60214302143euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910792;
        bh=8wnpy/r4amIarIKyUKZJdO9TIeHXMh0A0miVAgNTdpk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tknfD4LXX2ZxurZEC+g1jy35nR/FujMuRcBjonMUYOiYVLduWJlEzPEN3ObBvDwbF
         U3ZDcZ5/xuKdF0kMEriV8GU5gsc74hxxxXJ/vWvg81t/K4v3DbCKc04HQ6aLBJW+dJ
         aI+2TLr5YyWhcbZJfS3qyBU8WiBpnFO1MeFlBM/U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607123311eucas1p2138a022084a5943aa2fe0382621c335d~l6pmojjbH2443324433eucas1p2i;
        Fri,  7 Jun 2019 12:33:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.3B.04377.7895AFC5; Fri,  7
        Jun 2019 13:33:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03~l6pl3hAuo0536405364eucas1p1x;
        Fri,  7 Jun 2019 12:33:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607123310eusmtrp21751413f4019d6f4f4c9f43fbc990d4f~l6plmV3ki0991909919eusmtrp2R;
        Fri,  7 Jun 2019 12:33:10 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-6e-5cfa598711d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.F2.04140.6895AFC5; Fri,  7
        Jun 2019 13:33:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123310eusmtip2533c3314a7be362f283b58452646ab5a~l6plS6G8N2446724467eusmtip2C;
        Fri,  7 Jun 2019 12:33:10 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: cyber2000fb: remove superfluous
 CONFIG_PCI ifdef
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <2bacb06a-eb78-50fa-3e11-76ce20d89d6b@samsung.com>
Date:   Fri, 7 Jun 2019 14:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87rtkb9iDE79EbC48vU9m8Wmx9dY
        LU70fWC1uLxrDpvFoal7GR1YPS5fu8jscb/7OJPH5iX1Hp83yQWwRHHZpKTmZJalFunbJXBl
        LD3fzFiwmbni9an7TA2MT5i6GDk5JARMJBY/2cAGYgsJrGCU+PbZoouRC8j+wijxbsdyZgjn
        M6PE/uk7GLsYOcA6HrcEQsSXM0p8WLufDcJ5yyhxZuYnFpBRwgKhEt/Oz2QGsdkErCQmtq9i
        BLFFBDQkNs74BdbALNDGKPF01hVWkASvgJ3EnI/LwZpZBFQkrr39BnafqECExP1jG6BqBCVO
        znzCAnIFp4C9xLqLziBhZgFxiVtP5jNB2PIS29/OAbtaQmAeu0TD4ecsEH+6SPQd/sIKYQtL
        vDq+hR3ClpH4vxOkGaRhHaPE344XUN3bGSWWT/7HBlFlLXH4+EVWkM3MApoS63fpQ4LCUaLj
        aRyEySdx460gxA18EpO2TWeGCPNKdLQJQcxQk9iwbAMbzNaunSuZJzAqzULy2Cwk38xC8s0s
        hLULGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaY0/+Of9nBuOtP0iFGAQ5GJR5e
        B4afMUKsiWXFlbmHGCU4mJVEeMsu/IgR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9
        sSQ1OzW1ILUIJsvEwSnVwGh0fS/LC7vi54b3zLeZ2Sf8F+6W6eoJyDL6d4xjf/+dNYUrnCMu
        SCfot3rLhEafcnR6bDU3/iWndf/VSYnPi32n+tpMZytozLKca5o/M+iBYuqyjN5fZ1hnz9st
        +GNS3v0dlk4/dbcJialOUAhPyHvBmJm+VYjXoX+uZ6Pxu8g7uuoLV6aqKrEUZyQaajEXFScC
        ACaPMxYsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7ptkb9iDP70yVpc+fqezWLT42us
        Fif6PrBaXN41h83i0NS9jA6sHpevXWT2uN99nMlj85J6j8+b5AJYovRsivJLS1IVMvKLS2yV
        og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQylp5vZizYzFzx+tR9pgbGJ0xd
        jBwcEgImEo9bArsYOTmEBJYySsz77gIRlpE4vr4MJCwhICzx51oXWxcjF1DJa0aJl9+nsYDU
        CAuESvyZXQVSwyZgJTGxfRUjiC0ioCGxccYvsHpmgTZGiQMzTzNDzLeTOPDuAxOIzQtkz/m4
        nAXEZhFQkbj29htYXFQgQuLM+xUsEDWCEidnPgHbxSlgL7HuojNImFlAXeLPvEvMELa4xK0n
        85kgbHmJ7W/nME9gFJqFpHsWkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cT
        IzCath37uWUHY9e74EOMAhyMSjy8M5h+xgixJpYVV+YeYpTgYFYS4S278CNGiDclsbIqtSg/
        vqg0J7X4EKMp0G8TmaVEk/OBkZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1
        CKaPiYNTqoHRc8uUQob5X85cU5qvVuipvb17OU+Dc9H3ncZuIo4yd8JPCEkZTNg2JW3TtrPZ
        r9dnmN5geOu9oYEpcqH5/qlPmxemacQ9ef9F3bbn/BnvVe+vX+Y7uosnhfGVZt+bTW76kvLJ
        d5rZAjWOX7v3JlrBtT/vwsczXanbXSfMvL8gUzotq131ReZcJZbijERDLeai4kQA5pEQ5rwC
        AAA=
X-CMS-MailID: 20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03
References: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
        <CGME20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/19 3:44 PM, Bartlomiej Zolnierkiewicz wrote:
> This is a PCI driver and FB_CYBER2000 depends on PCI in Kconfig so
> there is no need to check for PCI inside the driver code.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
