Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23974C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADFB21E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hXez6iMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGVIly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:41:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfGVIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:41:54 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6M8fJ6b016279;
        Mon, 22 Jul 2019 10:41:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=imr2sIFk1Lgr/a7SvJT94lfftuDU4y9CMeO9VDYfTXQ=;
 b=hXez6iMHUuSntwF3oWe4Pl4zkYYP/Wx1TRbHa/Tc3cTMlkjqjCpCbtty7PHFUQzp5L30
 T9jc1AyDAzUTRbSMzK0qqVsObdAduryEQWSP75hreQ6iIpI8ymUVfeUCaxjiNN5pEWPg
 uaQCobSLRVELHWEVau2R/DJc8Ic4dDMdAF3D5Y6SdayS4E53DrsjyBYhoaiKlLDU0SCC
 2cf42Eas/XaQ/PoKw7D7SgkFRNOtDmC+B4nscaUxMnUJkED45MHI/jyqX9TMHXHeNAXt
 KmbYMsPSd3LoLBvOyDGPFy8SKXFWxvBFSNC2nxc+BHg5tCOpOL0P/is42mtPKYwCWHm6 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ture1ajgs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2019 10:41:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E18543;
        Mon, 22 Jul 2019 08:41:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9506F270C;
        Mon, 22 Jul 2019 08:41:32 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 10:41:32 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Mon, 22 Jul 2019 10:41:32 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Clement Leger <cleger@kalray.eu>, Ohad Ben-Cohen <ohad@wizery.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Thread-Topic: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Thread-Index: AQHVL9sMjAFFqcSPYUOpD1xKQA9Tl6a3MSeAgAAqZ/CACZ3pAIAQfN4AgAT4THA=
Date:   Mon, 22 Jul 2019 08:41:32 +0000
Message-ID: <3c2c98e785704969a862715ab52ce2de@SFHDAG7NODE2.st.com>
References: <20190612095521.4703-1-cleger@kalray.eu>
 <20190701070245.32083-1-cleger@kalray.eu>
 <20190702132229.GA8100@infradead.org>
 <58c8b8bd30a949678c027eb42a1b1bbb@SFHDAG7NODE2.st.com>
 <20190708184546.GA20670@infradead.org> <20190719063250.GA9545@infradead.org>
In-Reply-To: <20190719063250.GA9545@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: vendredi 19 juillet 2019 08:33
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: Christoph Hellwig <hch@infradead.org>; Clement Leger
> <cleger@kalray.eu>; Ohad Ben-Cohen <ohad@wizery.com>; Bjorn
> Andersson <bjorn.andersson@linaro.org>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
>=20
> On Mon, Jul 08, 2019 at 11:45:46AM -0700, Christoph Hellwig wrote:
> > > But that's breaking legacy as all platforms will have to add a virtio=
 device
> node in
> > > their DT file...
> > >
> > > Is it aligned with your view ?
> >
> > Yes, that is how I'd assume it works.  But given that until recently
> > you did now have these subdevices for dma coherent purposes we can't
> > really break anything older than that, so I might still be missing
> > something.
>=20
> Any chance we could expedite this?  remoteproc is the only driver
> inheriting dma ops to subdevices, and the only one using
> dma_declare_coherent_memory.  I'd really like to clean this mess up
> rather sooner than later.

Ongoing...
Two topics to clean up:
- Sub device creation and DMA ops inheritance --> need to use platform_devi=
ce or device tree
- dma_declare_coherent_memory use --> it has been introduced to support int=
ernal memories declared via reg field.
I propose to migrate existing drivers on reserved memory usage and so remov=
e dma_declare_coherent call from remoteproc core.
