Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DA2208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="stzuUfiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfFGM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:28:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58245 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfFGM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:28:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607122810euoutp023e99ad23f5f6c1b26a084a2db320e748~l6lOhtfS93241232412euoutp02V
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:28:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607122810euoutp023e99ad23f5f6c1b26a084a2db320e748~l6lOhtfS93241232412euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910490;
        bh=9ASUxj5X1jrQpmL6ymTtSaqw6S2iiehLeIZIb8+AUG0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=stzuUfiCzBPMrY/dOydbh/X7bUDcyYRE2aGiHbSXhWzJLgY75hG1onK2RiplkoE8q
         PbFjt4pLuJdH1QRbs3jGtb4UVDAt0NzLZWhO07aCcorai2AAa1KiyC4B/c5BERT+DW
         SuSb4Xe0Vo4IKBKFOrXKGAolkKrsoNrM+Ujg3NYM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607122810eucas1p23d355b67172644319b33da983470fa7b~l6lN44hFl1570215702eucas1p2F;
        Fri,  7 Jun 2019 12:28:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 79.15.04298.9585AFC5; Fri,  7
        Jun 2019 13:28:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607122809eucas1p1d770153cc51e01ee04c531d35d22e32b~l6lNBRerP2586425864eucas1p1B;
        Fri,  7 Jun 2019 12:28:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607122808eusmtrp1b6c64dcb6fa45ee2bbdec3679166624a~l6lMr1xjQ0101101011eusmtrp1W;
        Fri,  7 Jun 2019 12:28:08 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-5f-5cfa5859e5f6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.52.04140.8585AFC5; Fri,  7
        Jun 2019 13:28:08 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607122808eusmtip196c285aad43a27f8e1d7abff8c48477f~l6lMNXgVS2223722237eusmtip1U;
        Fri,  7 Jun 2019 12:28:08 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: imxfb: add COMPILE_TEST support
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <73094ead-2fbc-ba3e-3760-01918673ba30@samsung.com>
Date:   Fri, 7 Jun 2019 14:28:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7qREb9iDE481LO48vU9m8XDq/4W
        q6buZLHY9Pgaq8WJvg+sFl2/VjJbXN41h83i7/ZNLBYvtohb3J44mdGBy2PnrLvsHptWdbJ5
        3O8+zuSxeUm9x8Z3O5g8+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CV8fjEY+aCm0wV2/++ZWtg
        nMfUxcjJISFgInHz/WfmLkYuDiGBFYwSX9s/giWEBL4wSvz6kQaR+Mwo0fbuGhtMx52L39kg
        EssZJV53TYBqf8sosW7rBrAqYQFXiYnbuplBbDYBK4mJ7asYQWwRAQeJKTcmsIM0MAtcZpI4
        /HMPWIJXwE7izcTFLCA2i4CKxN91J8HiogIREvePbWCFqBGUODnzCVgNp4C9xNtL88EWMAuI
        S9x6Mp8JwpaX2P52DthFEgLX2CVuTdkC1MAB5LhIXJ/mAfGCsMSr41vYIWwZidOTe1gg6tcx
        SvzteAHVvJ1RYvnkf1BPW0scPn6RFWQQs4CmxPpd+hBhR4kj/Z1MEPP5JG68FYS4gU9i0rbp
        zBBhXomONiGIajWJDcs2sMGs7dq5knkCo9IsJJ/NQvLNLCTfzELYu4CRZRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgujr97/inHYxfLyUdYhTgYFTi4fVg/xkjxJpYVlyZe4hRgoNZ
        SYS37MKPGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2M
        y1omdGhu9Ghd6vLlx99s2WDRJY837N+SUj+r6kr8lT+mBUwagYlPe7X/fHSJ3LpMNPgx3+Oc
        fWv7Fn78+rYhxfo2K99KQaG5NTumRDoZXZZ6pB/ze+rvy2FOS1dvO79is9Fv3YDSqd5/rM7P
        2R7+bm5ljmvh+jcur2b/Wxfgw8NZt77PrJ1XR4mlOCPRUIu5qDgRACW5sLdTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7oREb9iDM6eNbG48vU9m8XDq/4W
        q6buZLHY9Pgaq8WJvg+sFl2/VjJbXN41h83i7/ZNLBYvtohb3J44mdGBy2PnrLvsHptWdbJ5
        3O8+zuSxeUm9x8Z3O5g8+v8aeHzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CX8fjEY+aCm0wV2/++ZWtgnMfUxcjJISFgInHn4ne2LkYu
        DiGBpYwSlzufMnYxcgAlZCSOry+DqBGW+HOtiw3EFhJ4zSgx+48oiC0s4CoxcVs3M4jNJmAl
        MbF9FSOILSLgIDHlxgR2kJnMAleZJB7tX8gK0WwnsfnmDnYQmxfIfjNxMQuIzSKgIvF33Umw
        ZlGBCIkz71ewQNQISpyc+QTM5hSwl3h7aT7YMmYBdYk/8y5B2eISt57MZ4Kw5SW2v53DPIFR
        aBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjcduznlh2MXe+C
        DzEKcDAq8fDOYPoZI8SaWFZcmXuIUYKDWUmEt+zCjxgh3pTEyqrUovz4otKc1OJDjKZAz01k
        lhJNzgcmjrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYx7K/9/
        NukVYVqdYlu9XSa6JOBE+3kBrbZb+uwlLEnCIgddHKWFD/mVS/IbSuitWPPuw+Nt3QL7nN7I
        /xGTP6Pp9zLxvO21Z7Ms+re4na5nv/LyW2BF6pF559brq3c8Spu+OzygJFB7TUbkYrZDE1bs
        2XprxW3rf4uzzHdrJQdPmLZ+3eYGp21KLMUZiYZazEXFiQDUMIby5AIAAA==
X-CMS-MailID: 20190607122809eucas1p1d770153cc51e01ee04c531d35d22e32b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607122809eucas1p1d770153cc51e01ee04c531d35d22e32b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607122809eucas1p1d770153cc51e01ee04c531d35d22e32b
References: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
        <CGME20190607122809eucas1p1d770153cc51e01ee04c531d35d22e32b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/19 12:47 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to imxfb driver for better compile
> testing coverage.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
