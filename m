Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818B9208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EhmbDfHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDAPNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:13:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34635 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:13:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401151311euoutp01c6894502e74590c2b50fd05bb9c36040~RYnK0HGgL2193121931euoutp01e
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 15:13:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401151311euoutp01c6894502e74590c2b50fd05bb9c36040~RYnK0HGgL2193121931euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554131591;
        bh=vLjTj7IfmtAikEV5INg7kQMt4IZUPmPXDriZXui4ahg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EhmbDfHDO1xhJrI7KESvYX/JjuE/BLdghYphepiofS4PHjXcu1+nhZjlRejakTwO/
         yljXiDPxxG4NFfE2wP/NQ9EA9usAlJL9g9CESJIPqhv+wv69k4wFa1pcd4xLmiJ+p/
         tqDB7lw9G3Ao767NR4RaoT91iE7/Cu9OUvOd58ig=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401151310eucas1p2e2f044984e6c5f4130b053e3af140aa4~RYnKK5Fza0656606566eucas1p2a;
        Mon,  1 Apr 2019 15:13:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.9A.04377.68A22AC5; Mon,  1
        Apr 2019 16:13:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401151309eucas1p17f6efc5a469cdadb76bad77a83e947b4~RYnJbHg_H1665416654eucas1p1f;
        Mon,  1 Apr 2019 15:13:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401151309eusmtrp260f2edc3b77c7cc58d86a7bc012cd5ac~RYnJNEZ_u3205632056eusmtrp2y;
        Mon,  1 Apr 2019 15:13:09 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-6b-5ca22a8693d9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.E5.04140.58A22AC5; Mon,  1
        Apr 2019 16:13:09 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401151309eusmtip2d70b7f6a3ee702d0c30b77fc831b988c~RYnI2pSuD3126631266eusmtip2a;
        Mon,  1 Apr 2019 15:13:09 +0000 (GMT)
Subject: Re: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes
 and gliches.
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e381bda9-e681-5ded-1c2e-f045ad689674@samsung.com>
Date:   Mon, 1 Apr 2019 17:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190331121801.ftwwm4dw2iev3xzf@debian>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7ptWotiDNZu4bG48vU9m8WJvg+s
        Fpd3zWGzOHB6CrPFmiV7GC2mzcxxYPPYOesuu8f97uNMHs/vP2XzmL27l9Xj8ya5ANYoLpuU
        1JzMstQifbsEroy/u7+yFmxnq/h1iquBcTZrFyMnh4SAicT+893MXYxcHEICKxglbu7fyQjh
        fGGUeLj8PRuE85lR4ufTxUAtHGAts/6LQMSXM0oc6bnHDuG8ZZSY8noHI0iRsECExO65cSAr
        RAR8JP783coCUsMs0M0osW3yJjaQBJuAlcTE9lWMIDavgJ3EmZ1N7CA2i4CKxPEbz8GWiQLN
        6T+jDlEiKHFy5hMWEJtTwFRi6slPTCA2s4CBxJFFc1ghbHmJ7W/ngL0jITCPXWLO/onMEH+6
        SHReXghlC0u8Or6FHcKWkfi/cz4TRMM6Rom/HS+gurczSiyf/I8Nospa4vDxi9AQc5To7p3L
        DgkKPokbbwUhNvNJTNo2nRkizCvR0SYEUa0msWHZBjaYXV07V0Ld4CHx6udKpgmMirOQ/DYL
        yT+zkPyzgJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCCOf3v+JcdjLv+JB1iFOBg
        VOLh5RBfFCPEmlhWXJl7iFGCg1lJhPdM/4IYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+i
        hQTSE0tSs1NTC1KLYLJMHJxSDYzdExpud6QaxfEbpr1dc17osTnvKfFlti/miHtKLAvfNreq
        /fQ1yaUntc6yt9QypP1v8FNo+R48p2PJmppFiYqeP7icG3req9/l/1/16l+TfHh4jUzhiUwV
        /yZfXrO1mpXL06adf7R/DseJpAVbdmYfEJ3man3wyt+XD894/dmgGLvqXpvws1AlluKMREMt
        5qLiRAAaX78SLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7qtWotiDJ7+krS48vU9m8WJvg+s
        Fpd3zWGzOHB6CrPFmiV7GC2mzcxxYPPYOesuu8f97uNMHs/vP2XzmL27l9Xj8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYy/u7+yFmxn
        q/h1iquBcTZrFyMHh4SAicSs/yJdjFwcQgJLGSW6l35mgYjLSBxfX9bFyAlkCkv8udbFBlHz
        mlHiyr1VbCA1wgIRElcOSYLUiAj4SPz5u5UFomYTo8S3K5vAGpgFuhkl3u58ygZSxSZgJTGx
        fRUjiM0rYCdxZmcTO4jNIqAicfzGc1YQWxRo6K2HHSwQNYISJ2c+AbM5BUwlpp78xARiMwvo
        Sey4/osVwpaX2P52DvMERsFZSFpmISmbhaRsASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxN
        jMCo2Xbs55YdjF3vgg8xCnAwKvHwRggtihFiTSwrrsw9xCjBwawkwnumf0GMEG9KYmVValF+
        fFFpTmrxIUZToCcmMkuJJucDIzqvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFq
        EUwfEwenVANje4/H4snLqlfWCiSniCf9+LPrbtnUmQIXQmokmbiXah8OXF0wd+G8ogdOf8N+
        Oz3qPDuDUzCWrUHz/9HzP2ft/Wskc+motaZ/1+MpM1OMmp3CJ2oyP75jc7bbw1NCSe72tEXl
        DKuPB7yRrCyKvZd53apfyz161jY/J8U18d8meuS0tny95suhxFKckWioxVxUnAgAcFlkZrAC
        AAA=
X-CMS-MailID: 20190401151309eucas1p17f6efc5a469cdadb76bad77a83e947b4
X-Msg-Generator: CA
X-RootMTR: 20190331121809epcas3p382bda421f972cd516bb7010700bc8a3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190331121809epcas3p382bda421f972cd516bb7010700bc8a3d
References: <20190316222504.27170-1-tomli@tomli.me>
        <CGME20190331121809epcas3p382bda421f972cd516bb7010700bc8a3d@epcas3p3.samsung.com>
        <20190331121801.ftwwm4dw2iev3xzf@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/31/2019 02:18 PM, Sudip Mukherjee wrote:
> On Sun, Mar 17, 2019 at 06:24:56AM +0800, Yifeng Li wrote:
>> Hi all,
>>
>> This patchset contains a series of important fixes to various problems,
>> including lockups, crashes, screen gliches, and missing video modes.
>> These patches are crucial to the correct operation to the hardware,
>> especially Lynx3DM+ (SM720). I have tested and verified them on x86.
>>
>> Please review and queue them for linux-stable.
> 
> Thanks for the changes.
> Verified the register changes from the datasheet and also tested the full
> series (separate test for individual patches) with SM712 on little endian
> for any regression.

Patches #1-8 queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
