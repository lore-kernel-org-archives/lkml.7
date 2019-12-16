Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016D8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63EF206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="A9X5Cgq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLPLvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:51:35 -0500
Received: from mout.web.de ([212.227.17.11]:53101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfLPLvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576497065;
        bh=ndoUJiN+5aboVDuM7327NMBR7hvKm462DVSZE8B0Ans=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=A9X5Cgq2Pkh0mReqgtNObXQcy1Pc8wscLZf5iRgLm79oqRFvRnhrXVBo5/gqaS06T
         ROrulaszTvVgeWNmVSwL7yQuxMeIIPaoryfHuIhB4iARllBybjUMwk2NXx3tl6LWb2
         uRCBdcVsO0YJQ3ANr8bnb23RPhPh35jEo9TsqWf8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.181.202]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBPe-1iLIyk3mJS-00PxR7; Mon, 16
 Dec 2019 12:51:05 +0100
To:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191216062806.112361-1-yuchao0@huawei.com>
Subject: Re: [RFC PATCH v5] f2fs: support data compression
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0ab8c593-d043-cdf6-7805-f7bceba8e519@web.de>
Date:   Mon, 16 Dec 2019 12:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216062806.112361-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TT2NeFbpx2eiQdsSNVkS7oXx645G/9dhZoLvu1C0ikwBJllIAQn
 s5j8zGinPPKV/saY+ou5HDd2cy2ozGqJa6SnhmmF2EHpKvI3SsMzu1gR0f7E6i/Bz7ED6TY
 U4MXL05KptDHflyhRbJdoNqv6qZxLUqNq1F2mWZn8P32qSjSRsSphMaB13Xm+RP1aV+ye+Q
 oI+QBNqrx56Nj7HpxqzuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+j7nDihIYc=:EgXTh4Qj0vLN4lAxlE1SgK
 3u3JXxDuthwcTxHSnJtRhhGZGgkzdPgnXOXbFKHSOYwmPYgEXDp61eT3KMfjw4E6RYks+D7Y2
 GX1FWa4UADNkVp6LAfho0/9whAzV9WVIfieENfL+3MS/7kvSDBayUk8iK5Mclkva9p8Ps25p3
 RR2qO8Y7S0kfrtsRxtuLyAvQfE30eRuv1Yp+ZQBwBXky5uxn+igRO4h94MpdortPcl3/YTRS7
 CKx7YhriDy6sd10oLHXegOscK/cNpeY8S7MBy48t3CXoLl2cbI8eMP02jWssTfc37XH8mguUt
 v6dGEyj6izBd2wXyYa3VglnSvmGm04TJG8NvZalDalmNoDhif9rmU7eCJlJlncwIlkqyp1Wz4
 qRlHlXevUpTKfwcl7ljVMHwovlSBgEh6Ypl5yzpx7UewOs9LoEwV3rO2o7xmC6AA5bwFIkbzs
 LCK/g/E3erK64VpWjS/SfehwEA+zjhLZBGTxiM8NuQZ0wH/zDjXCaFU8X4WlrhXamQra513bP
 IxOZ9oS34Gq71x7j5aXvKjAFp4YKTysm6b8CZp84rq/s53oQLvuVTIcRfnmLdkCmICDoi/t/1
 G1k7VN2T+qJJGtIynIN72LszZ7RTda0hxeyatUZ3AWxBcx1qLe50EOLkjNIR1YQWNTvglLGsX
 EKmEAtXKwc8KXGdpaikQjQ2lOnljocYdITRTNaftPtZHqDG/lSf2accYLnD/V033hGQ2sEDKR
 /TVHjE6TMXwo2vhd0HRwrTo/lbg7vbKb8KpDx2zMAaCfHEL/1I6kpPmjhyZjBgR+WRsiinHpG
 f8nEXAywohLu1G0W2ZTKt0mCtPAuWVDrF2yLXwAsJCTScX9+YmoMwI7NVBevaa6lY77HoTlxk
 uXdVneoQcNiwgXZHHMGGsqrmMphSRpSXCIjy9zT6r+iDGeri1DFwd1P9cjnqKWzvG2X+Ry+Dx
 fTNpbNkGIQVYhBBTXgp74TJLUykDGlHReKvYAjWdc2PFlEEcyQA8XwiB4wpm8GYwt/C8b4VT7
 kSDIE+X/DsMBHEnu8WcL13+fXOlvNW5SYdFDM/sJhfmYbINqGj3+IIhtMK+QqWb6p1w/bZiC6
 +y7t3ejMpJyE/gcwwRvg60vCsjy4YjktnEd/c97+FEUcVpaOukF5Dh1s9Y9bY+H7qXN5tq9hH
 yHPDIk5QLr9YlLMohwAYaw1nt+Tn8q/JeSgA4SGl1SDHqHrv8b/wSXDA0wklC9xrx6o5wPWH0
 rPIgzP87qTZofXASkDldhw6iRXk7BtBjxeqVrnXp3DLqcn6vu415p+Jl4ww0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/fs/f2fs/f2fs.h
=E2=80=A6
> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> +bool f2fs_is_compressed_page(struct page *page);
=E2=80=A6

Can the following adjustment make sense?

+bool f2fs_is_compressed_page(const struct page *page);


Would you like to improve const-correctness at any more source code places=
?

Regards,
Markus
