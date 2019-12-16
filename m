Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07200C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1159206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Uk02i/mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLPLcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:32:33 -0500
Received: from mout.web.de ([217.72.192.78]:44481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfLPLcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576495930;
        bh=ScEN8n3GV+WMJgfH5FlVtKpqjsLsOHIgy5pLVHm/22g=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=Uk02i/mPN6wHepBgQQm5RBJeoOiV2O9+Xig6UE17gqutji+xUxBRsldobOydiYx1X
         L8kZ5qBy7EjJZYESZHiIprQISEiYXDT9jCV2CNZ5N4eYg4cE/++qKM0gSkdyxNsyVU
         g3Ev7W5su/RdRfSUbjKIhWAQidE8N/0Ay15IbO+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.181.202]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUW7T-1iFUBG48l1-00RIWn; Mon, 16
 Dec 2019 12:32:10 +0100
To:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191216062806.112361-1-yuchao0@huawei.com>
Subject: Re: [RFC PATCH v5] f2fs: support data compression
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <594c3b59-b6f0-0e87-6acb-04161e555d7e@web.de>
Date:   Mon, 16 Dec 2019 12:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216062806.112361-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pip56QvaNsPXkcUF8CD2nIcFfLq1yUdoc94D3eknuvUIUmZ5hl
 WreGNVq7+OTt1xYhZOGybwdZ0pv2os1vFLGY9W99loHzr7nGIgffrJfFVW1B8V1fN6DpfSA
 vEDtoTXCJLt5T4rMrmKozbBPct0r5sA9t3u/iHovH/JFigD0i9sTiWBv6aENcSSCS+LT4Kj
 8RyYztQEvzLR1pomAn50w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEnQUXtpG2M=:o/KpONtZB0jc6lMeB5oAsl
 bUAdfrA07oALR0urToFJH9zI2tHnpMHCt1+fhkWb6dSjiJnSfZkW6t56QzBVuSd87vrCllvrB
 wMP6Xo3Wvt1dxqwFZeYgJAbMoLHhr+lx+XBQoccQNnWtU3b+2oLy3t/BgOkaSRxwdtmTbDpJu
 1fvfQKWR1I2xcRpjyhrcE/Dmm9pYGWJHTLZRgYSU+8I8HGvihiehkw6u7TZ00Yq5/X5Jm0TXq
 yrszz+AICqdv/fIsRbfaf6okw5wF/e8vIN2zvP2jI8U+k4/HteWaWcoQKYzs3w4rVArYT27NF
 6R8vPrZzyxbTSeiN0KzQyjC2a2K2tSZnesRyyjE9PpOvzaf5Oso9rAU+tQWeciBe5kavV9//o
 e7jMvb/N+E7FkWzMkKyfJacGkB0095y9yr9dNblOIjLUY6Gwi4FFqf86X+IlY8p8H5AX/dZEO
 5xrRENSorKPwDmbUPy1gzbCqsLGZOy22ot/ROV0Ku/qS2pbJpK6any7FX5H6di+brSzu3UKRg
 e8le+GW5o7mAp/MBaoOZwzobPztJOLpS9q80z3iX5l0vuJIfFz6gmMy4qe3j4t+lZ+1W93j3a
 +o+cFe88OLgueltdCjq+171eMdKeZM37uJIfE7iVWIUnDx/ZsP67KOqudjhF77ujZbS3hP3nk
 A5aBDkXj74/NBM7k01MYpm5Z+TY0yMti27JYNH6EqqCHHY0nnKVVVzWLuPo2fW/vVcobq45J8
 4cEEh7xWfgh9TMtstFKTGHGfC14PfCJB0ERFFi1mFgpodtzTt5aD3PGeWlv5MDxyOqIjOLMfn
 K7E+NReNCyGYBb4EkexNhmV444QD4ELdr9VY0gm9nKhWksa97KLsIA3wllvKWKN1vubF+14y9
 5fwdNU0Jekc/6nTZ+fI+SDY2hF/YtFoBT1AMNmMDWrzF3cmudu/0CRxId0JsZ12BZtQOfNlif
 odL0HSCLJnbeXQzbK/u0Pxua+WfAqHTgqUFgYskqdM1/mpxr3E1UTYJkXbWugcRD49H+GcHzD
 BwbDPvRa6JT2fuYwVD4VFwdD5mrS9boaq3AOVd0ygPmGavDKdlXZ1Bptp+2YzRbH5cmMw9APN
 lBNJQnOmgBOa8fqO6Vx/VlkQwZ2ANxGLmqiESHwzHNXez7deYGYmOHE9+A6kaVMZ4ZiPecioQ
 YFQ/Y74C6bObuwhraTlv1XwvP65lPdwDo5gJHpEJuZcxx2zVUINKypmF3blYRkR7i/MlrsDLW
 xb+7eRALnAF7s6XnjQzz7sc3y9ih810f/8yLeRr0zFwz96hj54nBHrXR6VPg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/fs/f2fs/compress.c
> @@ -0,0 +1,1139 @@
=E2=80=A6
> +bool f2fs_is_compressed_page(struct page *page)
> +{
> +	if (!PagePrivate(page))
> +		return false;
> +	if (!page_private(page))
> +		return false;
> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
> +		return false;
=E2=80=A6

How do you think about to combine condition checks like the following?

+	if (!PagePrivate(page) || !page_private(page) ||
+	    IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
+		return false;


Would you like to apply similar transformations at other source code place=
s?

Regards,
Markus
