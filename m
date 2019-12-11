Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3266C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB2E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VvD10Ez0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLKFWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:22:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57350 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfLKFWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:22:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191211052202epoutp0385bd9e2a3bd519b0a1648fc87c68c2b6~fOZiTclTx0872208722epoutp030
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:22:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191211052202epoutp0385bd9e2a3bd519b0a1648fc87c68c2b6~fOZiTclTx0872208722epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576041722;
        bh=LAZLvvExbGhSMU9CrBL0f+mi5y5whc4oHHjen45alVc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VvD10Ez08bDstL5o8GQsLpKs1Y5SZggBF/DH2RswmHJT/XP0GP53HIBamG5IpTO7Y
         8DjumygVrmUmC6FP+zDKexgtbvwb//B8/AN1WtXExgfdzi/9zStusKapU3Jj9ofbBj
         uw4pHeo1C4fUSW7wVz2Zjlk3w1wK9DUu62nBA2kI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191211052201epcas1p317994dd818153d76e46d1c4c42e130a3~fOZh21Cf01020910209epcas1p3h;
        Wed, 11 Dec 2019 05:22:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Xlfc6DYvzMqYm0; Wed, 11 Dec
        2019 05:22:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.08.57028.8FC70FD5; Wed, 11 Dec 2019 14:22:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191211052200epcas1p1e26270f59e2aed6fe62544ceaa295573~fOZg1W34U1953819538epcas1p1M;
        Wed, 11 Dec 2019 05:22:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191211052200epsmtrp152d99171da85fc14cb0d219f677c5b49~fOZg0vG4v1977619776epsmtrp1d;
        Wed, 11 Dec 2019 05:22:00 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-c7-5df07cf87882
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.F8.10238.8FC70FD5; Wed, 11 Dec 2019 14:22:00 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191211052200epsmtip2c06cd5e704b61d73ced08bcb3fafd5d0~fOZgoM_i70186301863epsmtip2N;
        Wed, 11 Dec 2019 05:22:00 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Vyacheslav Dubeyko'" <slava@dubeyko.com>
Cc:     <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <288f07e3573e1dd242a892a6aeef211cda68bc61.camel@dubeyko.com>
Subject: RE: [PATCH v6 03/13] exfat: add inode operations
Date:   Wed, 11 Dec 2019 14:22:00 +0900
Message-ID: <005201d5afe2$ea285880$be790980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJ4BHLZ9o05RvmzeddUXNtWjOPDsAKi8sUOAoVHeEQBkFJCUaY597lg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmru6Pmg+xBjN/GVk0L17PZrFy9VEm
        iz17T7JYXN41h81iy78jrBaftsxmsrj0/gOLA7vHwfVvWDz2z13D7rH7ZgObR9+WVYwenzfJ
        eRza/oYtgC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxr790gUnmCq+t01ibWBsZOpi5OSQEDCR2L72IXsXIxeHkMAORonfy88wQzif
        GCUmPDjPCuF8Y5RYebOPGaZl8bfHjBCJvYwSC59fgGp5xShxZE0XK0gVm4CuxL8/+9lAbBEB
        PYkTG86DFTELrGCUePJ+Mth2TgFPiYbOmewgtrCApcSa2xvBmlkEVCVm7D0Gto4XKD5/8yo2
        CFtQ4uTMJywgNrOAvMT2t3OgTlKQ2HH2NSPEMjeJxl2tjBA1IhKzO9vAFksIfGeT6OlcwgbR
        4CJx9d9FqGZhiVfHt7BD2FISL/vbgGwOILta4uN+qJIORokX320hbGOJm+s3sIKUMAtoSqzf
        pQ8RVpTY+Xsu1Fo+iXdfe1ghpvBKdLQJQZSoSvRdOgwNd2mJrvYP7BMYlWYheWwWksdmIXlg
        FsKyBYwsqxjFUguKc9NTiw0LDJEjexMjOJ1qme5gnHLO5xCjAAejEg/vgu3vY4VYE8uKK3MP
        MUpwMCuJ8B5vexcrxJuSWFmVWpQfX1Sak1p8iNEUGO4TmaVEk/OBqT6vJN7Q1MjY2NjCxMzc
        zNRYSZyX48fFWCGB9MSS1OzU1ILUIpg+Jg5OqQZGWbmVugzC1nt/+U02ZdB9uqe+ssiB/dNn
        K6fcLWz6nAvu6txymzVf6PxWu2+8U8q497lYvbgSf3mRzpN9d9a9/rm4+c3tKQYrtkuHTBLc
        cajStpVNuTDmkOuj5/su2L5fmHkzLW9NX/zWE9e63wa4pSxl3u7bPflM4t7krtnhK6YfrrzP
        8i+7VYmlOCPRUIu5qDgRAKT6diO9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO6Pmg+xButfSlg0L17PZrFy9VEm
        iz17T7JYXN41h81iy78jrBaftsxmsrj0/gOLA7vHwfVvWDz2z13D7rH7ZgObR9+WVYwenzfJ
        eRza/oYtgC2KyyYlNSezLLVI3y6BK2PffumCE0wV39smsTYwNjJ1MXJySAiYSCz+9pixi5GL
        Q0hgN6NE78KdrBAJaYljJ84wdzFyANnCEocPF4OEhQReMEqcnFwGYrMJ6Er8+7OfDcQWEdCT
        OLHhPDPIHGaBdYwSy+/vYYMY+otRom3uDrBtnAKeEg2dM9lBbGEBS4k1tzeCLWMRUJWYsfcY
        M4jNCxSfv3kVG4QtKHFy5hMWEJtZQFui92ErI4QtL7H97RxmiEMVJHacfc0IcYWbROMumBoR
        idmdbcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4m
        RnBcaWnuYLy8JP4QowAHoxIP74Lt72OFWBPLiitzDzFKcDArifAeb3sXK8SbklhZlVqUH19U
        mpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAOj2M2lzMGccpu1lupfdpOqVEg8
        aGp/pJzp7MMrN6Y1hATay7ie2uv6y4vz4brc1z2B8zJ+ZPAfmtPUKrL01LWqr1ELd+8z/zPD
        JWVjy+XjqoaWG7fu9nrqb+nu7p7Wcbd8qYrMm2Vqz3/dPmSQ+XP99Ai3+0y+GhKNxVeaV04I
        cOKb69OzK26GEktxRqKhFnNRcSIAsDIYYKcCAAA=
X-CMS-MailID: 20191211052200epcas1p1e26270f59e2aed6fe62544ceaa295573
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065459epcas1p3349caea59da1b9b458a73923d724ca35
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065459epcas1p3349caea59da1b9b458a73923d724ca35@epcas1p3.samsung.com>
        <20191209065149.2230-4-namjae.jeon@samsung.com>
        <288f07e3573e1dd242a892a6aeef211cda68bc61.camel@dubeyko.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	ep2->stream_valid_size = cpu_to_le64(on_disk_size);
> > +	ep2->stream_size = ep2->stream_valid_size;
> > +
> > +	ret = exfat_update_dir_chksum_with_entry_set(sb, es, sync);
> > +	kfree(es);
> 
> The exfat_get_dentry_set() allocates the es by kmalloc? Am I correct?
Yes.
> 
> 
> > +	return ret;
> > +}
> > +

