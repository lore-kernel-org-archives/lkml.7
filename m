Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8BF217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Yft2/SB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfGQSeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:34:31 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:40904 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727377AbfGQSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:34:31 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x6HIVgsu011513;
        Wed, 17 Jul 2019 19:34:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=4qMDk6GdYd6oIMIaSO7765g7DBUTGEZb/qDIz2MM7vk=;
 b=Yft2/SB4FXRQYN7RXB5BW8+5XnkS7SWdGWNDJlJGxJgTj7ukxHbNo5d9WCWfNUwGVFFu
 hOHfJpvcyolcPGCuJN6HKluOZvJYusxn3m51LdGbE5wnOx8lLmDTiD+jWpE83ZE+l8Lh
 FwN+hlI7kUBNU4Eqmka2iYoZASxpxvxSlDWfCShA5VTY1omSiUlBlytFXiUTZ7qiKh0D
 lJolQOpSaR0w6OkxeTh+BnIy8plA8JOPUq6XdcFnMYUSVmOHt/Ss0kbtHncz/FlC68Bb
 I1h0ktAphNHtePAUZvu2/F5364awrjhkTPZe8jB6dsiZsYKhwtPXo+POjndweL/87hoK wQ== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2try9prxa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 19:34:02 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6HIWIYD001630;
        Wed, 17 Jul 2019 14:34:01 -0400
Received: from email.msg.corp.akamai.com ([172.27.27.21])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2tqamwnfd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 14:33:59 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.27.105) by
 ustx2ex-dag1mb1.msg.corp.akamai.com (172.27.27.101) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 17 Jul 2019 13:33:58 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.27.105]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.27.105]) with mapi id
 15.00.1473.004; Wed, 17 Jul 2019 13:33:58 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Topic: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Index: AQHVMTPFo1SW8Ha07Ua7MbRsBb5FgabNV64AgAAy/wCAAUQogIAAamrQ
Date:   Wed, 17 Jul 2019 18:33:58 +0000
Message-ID: <4693ccba52114913afaafd498ae284de@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
 <20190716084744.GB22317@krava>
 <cd2b162a59804cdaa7f4de18c3337aa8@ustx2ex-dag1mb5.msg.corp.akamai.com>
 <20190717071027.GG28722@krava>
In-Reply-To: <20190717071027.GG28722@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.33.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170210
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday, July 17, 2019 3:10 AM Jiri Olsa wrote:
> On Tue, Jul 16, 2019 at 05:01:26PM +0000, Lubashev, Igor wrote:
> > I could add another patch to the series for that.  Any suggestion for w=
hat
> capability to check for here?
>=20
> it's:
>=20
> 	if (geteuid() !=3D 0) {
> 		pr_err("ftrace only works for root!\n");
> 		return -1
> 	}
>=20
> so I think check for CAP_SYS_ADMIN should be fine in here

Thanks.  Added the [PATCH 4/3] to this series (https://lore.kernel.org/lkml=
/1563387359-27694-1-git-send-email-ilubashe@akamai.com/).
Let me know if you'd rather I reroll a V2 of this series.

- Igor


>=20
> jirka
>=20
> >
> > (There is always an alternative to not check for anything and let the k=
ernel
> refuse to perform actions that the user does not have permissions to perf=
orm.)
> >
> > - Igor
> >
> > -----Original Message-----
> > From: Jiri Olsa <jolsa@redhat.com>
> > Sent: Tuesday, July 16, 2019 4:48 AM
> > Subject: Re: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_parano=
id
> checks
> >
> > On Tue, Jul 02, 2019 at 08:10:04PM -0400, Igor Lubashev wrote:
> > > The kernel is using CAP_SYS_ADMIN instead of euid=3D=3D0 to override
> > > perf_event_paranoid check. Make perf do the same.
> >
> > I see another geteuid check in __cmd_ftrace,
> > perhaps we should cover this one as well
> >
> > jirka
