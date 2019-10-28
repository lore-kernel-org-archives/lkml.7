Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C29CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B5B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SY8rht9k";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IlkDwdfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJ1WQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:16:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5168 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfJ1WQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:16:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SMGGCb009159;
        Mon, 28 Oct 2019 15:16:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+bGOIAqZDWfiFI1MbUKHfxEfmNgNvzTznsyZg0VJUsE=;
 b=SY8rht9kEhBWG9t59Lg4YzwBiiLcyMJEiZLPbKh7GAz56aoYzYMCEqiuhvO9OTPcorNB
 BYgcPW5OqKOeXYXcFDuvKSA7r0cLSoOIAAtAs6EuPUIfJNiuTo21oKpN6AvZ5Oyd+cMe
 ynmWvLtBUXnkmFzcYM/JPNxub0WKrXE0Pe0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vvknjk6p1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Oct 2019 15:16:18 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 15:16:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Oct 2019 15:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkBK/KmI9viP/G1niLPqGfM8cojNmEupaUp8QS9z6u6H4UFTU+zxIjNs7fdxHiaFik1pLM7SrwC1jkqv1PbZS4lS/Pga/7IJrune2Z0L4fo3jHL6ULJ/0YpFk+S5d3xiZzbl0ecjrkVlZMLeNPuq70cujzyEhS03DBpt+UbrsdFfxPEV3wS6dFimQcDwgmfqLrlz6YsSdZwt9WmlZAIUCWzrtEP/u8tzXcvlqT55HB/hMqG2BcNEfinYMr9KbRfNSO0uhv3u3dI9F/NsnMyjHj+4vWALkvoa1YWfJtqD0WieBnbcqvmc0W1cPJpDLHkNErWzUDHOj/Xf/e6kcyDigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bGOIAqZDWfiFI1MbUKHfxEfmNgNvzTznsyZg0VJUsE=;
 b=oC4sJI61oyNVx11J15a/SWuPnVTDsow6a+AuDNwE6Li/riMnkZnONyiHRmWovaAhQ3FnD2fRDOKKKQjatjYxgdqk5IPr7XXVyab+S9IgJQRc/N2IQ3otBf42IxzPg25LxHTTDpgpeiXl1bMwjfIvZE1zMYoDhyMFu794jTN+b3ZU632yL5H5DZSK3G8/ks4k+fzOs3nQbS4Qp/abrYr1QGBVN/4z9I7UPA5fCHQbRrCx4Qfg6QTodLkmwkEkXybY/stZwuQ1EUuM8wMtQ06G4mwM26ARVzfdkKWiAdxB1oUVnlJSY7rPWOaxNL/0gRX3Ta74diM+tUZxZbxHxt9x0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bGOIAqZDWfiFI1MbUKHfxEfmNgNvzTznsyZg0VJUsE=;
 b=IlkDwdfOg+32cM+1KqqndLsUVm37td1DCcT7EdWD9oa9hMT+AYI37M+4+x6TzYvQEJa9RhWRbse9IOI8inbT9H4hbnYUK/IEpr+o+uz1xxl48JgzcG1np2TSMxM440yg/o+hz68aP3mEWuGqcE5i+NHTAn9R/j+luW8SHsYrSjo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1711.namprd15.prod.outlook.com (10.174.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 22:15:59 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 22:15:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     syzbot <syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: INFO: task hung in mpage_prepare_extent_to_map
Thread-Topic: INFO: task hung in mpage_prepare_extent_to_map
Thread-Index: AQHVjck0AXGPtEIKWEas0QCK1EXfO6dwfRoAgAAh3wA=
Date:   Mon, 28 Oct 2019 22:15:58 +0000
Message-ID: <70FEE01E-654E-4C4A-BF5C-B0A06A073A5C@fb.com>
References: <000000000000c50fd70595fdd5b2@google.com>
 <20191028201444.GA27425@cmpxchg.org>
In-Reply-To: <20191028201444.GA27425@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3:4b54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 861a41c5-6be7-45a5-5da9-08d75bf4692e
x-ms-traffictypediagnostic: MWHPR15MB1711:
x-ms-exchange-purlcount: 7
x-microsoft-antispam-prvs: <MWHPR15MB1711C8EC295B82F9130575E9B3660@MWHPR15MB1711.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(66556008)(25786009)(33656002)(186003)(64756008)(66476007)(2906002)(102836004)(53546011)(6116002)(76116006)(14444005)(66946007)(6246003)(99286004)(54906003)(256004)(229853002)(36756003)(6506007)(476003)(6916009)(76176011)(446003)(2616005)(11346002)(486006)(46003)(5660300002)(7416002)(305945005)(50226002)(66446008)(4326008)(6512007)(7736002)(478600001)(966005)(81156014)(81166006)(71200400001)(8676002)(8936002)(6486002)(14454004)(6436002)(6306002)(316002)(71190400001)(86362001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1711;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PolduS5k/r//M9e0HvQFeNBVHa0YWeBF7gk2NHMKtiXGmzOhOS37r6oSBcCQ2LCaIZEu+XDHCce75Bkrh+lnM7AfekHm9JqwbAbavUN9oGY1sBri4S+L1ycUsTcS51TOotjcCHMAo3z3jtKPfuB0Joy+X+xTcm64Q0XhmquwVsdMtync5RGfbNBxet5P/WkbIJJ6cmnzO1gDGBn2pPTbEfjXhOgn/wb9Kp/7qpnNPNFmiLHKXJTXrS2+NYlfph/jIGKY0FxxApTkzmPQmoL6jou4rTz+n4flgxXuHTtswi4CyY97Eya/K69dDp7rxTCzVD1yeuU+wh/1pnHpecliweH6p5eKeoCo4Uj+RfOGQuPD9E1tftQakvJ1V44J1GWKL9cipFyz+2Cv3HelpdPoVuyMlI14B39TCatT2gIMX86PuYz29JXjUpLlstT5NIAIkBr3VgBGv0dKZIYPqan3puEpy1D3qILRZB6Z5tYbA1s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <826D420DE97C16469A3EF6EA15375C83@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 861a41c5-6be7-45a5-5da9-08d75bf4692e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 22:15:58.8879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efOrsm3S4/8pQim2qnbt+rLueSneAVOp7mC7meI+kXVtUn7Dl/Tb/AcBwh1+1nSgY0Sp0eZ8pexby3j+mEAlMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1711
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280207
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 28, 2019, at 1:14 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Mon, Oct 28, 2019 at 12:52:09PM -0700, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following crash on:
>>=20
>> HEAD commit:    12d61c69 Add linux-next specific files for 20191024
>> git tree:       linux-next
>> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_log.txt-3Fx-3D15a0fa97600000&d=3DDwIBAg&c=3D5VD0RTtN=
lTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5RP=
2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3D6-TXLGQxJcK1GdwMwa51423Y221rRncNiC_=
T09O0OLc&e=3D=20
>> kernel config:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_.config-3Fx-3Dafb75fd8c9fd5ed8&d=3DDwIBAg&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5=
RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DGuFgLJZOb7jtjZ5mDbkVT_zqtiVW4Py13=
e6Oq5CFxgY&e=3D=20
>> dashboard link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_bug-3Fextid-3Defb9e48b9fbdc49bb34a&d=3DDwIBAg&c=3D5VD0=
RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaO=
e5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DpF1hv-zGR8F378weGq9zxCE5ibI2_73=
qweMB_KuaZLM&e=3D=20
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_repro.syz-3Fx-3D13a63dc4e00000&d=3DDwIBAg&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5=
RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DmI7ZOgrDWeG-p6vn2d_kj65a5g8J7exXJ=
2MIUUF84-w&e=3D=20
>>=20
>> The bug was bisected to:
>>=20
>> commit 9c61acffe2b8833152041f7b6a02d1d0a17fd378
>> Author: Song Liu <songliubraving@fb.com>
>> Date:   Wed Oct 23 00:24:28 2019 +0000
>>=20
>>    mm,thp: recheck each page before collapsing file THP
>>=20
>> bisection log:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_bisect.txt-3Fx-3D13eb6ec0e00000&d=3DDwIBAg&c=3D5VD0R=
TtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe=
5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DYtSUy5Dtjo6tek7CvwzMTPL40BJwOC6r=
Eom-AkVx0SM&e=3D=20
>> final crash:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_report.txt-3Fx-3D101b6ec0e00000&d=3DDwIBAg&c=3D5VD0R=
TtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe=
5RP2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DBvPJx3QSPHgsN12jSZci_MqW_VxYp-MZ=
pQtogZjlJOo&e=3D=20
>> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_log.txt-3Fx-3D17eb6ec0e00000&d=3DDwIBAg&c=3D5VD0RTtN=
lTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3DYEaOe5RP=
2hLXAC4tKPLehAQsea0_3k3tI4DL32BcA-8&s=3DYPvxWpQDpk9MI9W6QCtxME64wmxL2CZ5ZtE=
kCn0nI0c&e=3D=20
>>=20
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:
>> Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
>> Fixes: 9c61acffe2b8 ("mm,thp: recheck each page before collapsing file T=
HP")
>>=20
>> INFO: task khugepaged:1084 blocked for more than 143 seconds.
>>      Not tainted 5.4.0-rc4-next-20191024 #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>> khugepaged      D27568  1084      2 0x80004000
>> Call Trace:
>> context_switch kernel/sched/core.c:3384 [inline]
>> __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
>> schedule+0xd9/0x260 kernel/sched/core.c:4136
>> io_schedule+0x1c/0x70 kernel/sched/core.c:5780
>> wait_on_page_bit_common mm/filemap.c:1175 [inline]
>> __lock_page+0x422/0xab0 mm/filemap.c:1383
>> lock_page include/linux/pagemap.h:480 [inline]
>> mpage_prepare_extent_to_map+0xb3f/0xf90 fs/ext4/inode.c:2668
>> ext4_writepages+0xb6a/0x2e70 fs/ext4/inode.c:2866
>> ? 0xffffffff81000000
>> do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
>> __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
>> __filemap_fdatawrite mm/filemap.c:429 [inline]
>> filemap_flush+0x24/0x30 mm/filemap.c:456
>=20
> This is a double locking deadlock. The page lock is already held when
> we call into filemap_flush() here, and does another lock_page() in
> write_cache_pages().
>=20
> To fix it, we have to either initiate flushing before acquiring the
> page lock, or simply skip over dirty pages.
>=20
> Maybe doing vfs_fsync_range() from the madvise(HUGEPAGE) call isn't a
> bad idea after all? (I had discussed this with Song off-list before.)

Thanks syzbot and Johannes!

I just sent a quick fix, that just removes filemap_flush().=20

I will work on a better mechanism to flush the file.=20

Thanks,
Song

