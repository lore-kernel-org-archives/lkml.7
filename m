Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD070205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yVZqQAMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfCZQsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:48:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbfCZQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:48:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QGdWkw001457;
        Tue, 26 Mar 2019 16:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=dKjyO/FnSBGo51IMvNBbqDJzxKeQazWW9tRRvGN4jGg=;
 b=yVZqQAMduyM3DQtPFuoZmprJiv2vqyTSKgZFHqTrApqBttL6glO1OHHjQLZNnYBQnzam
 54oODSAnp+FUj3yOGG53y5YTdekrbypGR/vXbtWpngf9QEv6u38LvNDMYACAKXzid9oD
 vMEzHzNRgk9VVIMu/kpp2qphJLtHe2UdFrCrG/frW8yBOVl4vo0Sl7NZkd+rlB8KdJwl
 VVxkWThvbyO69P/ITooiDjJgjPuomJ6aescXsjxWXfbOqd9aTEIF6DMG+nGUMbosTi9W
 TO9o6nkCb/b6A+LznZ1MkntpAtz1wL3pzJUjqn2TogY4Ik+GK+Xd1cVl++NSSE3r45Pf Qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g13n90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 16:47:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2QGlpk3026262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 16:47:52 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2QGloUc032010;
        Tue, 26 Mar 2019 16:47:51 GMT
MIME-Version: 1.0
Message-ID: <9c3849cf-86c6-4568-bff5-1050b445322d@default>
Date:   Tue, 26 Mar 2019 09:47:50 -0700 (PDT)
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     <qemu-block@nongnu.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>
Cc:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: megasas: Unexpected response from lun 1 while scanning, scan aborted
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=679 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am reporting an error that the scsi lun cannot initialize successfully wh=
en I
am emulating megasas scsi controller with qemu.

I am not sure if this is issue in qemu or linux kernel.

When 'lun=3D1' is specified, there is "Unexpected response from lun 1 while
scanning, scan aborted".

Everything works well if 'lun=3D0' is specified.


Below is the qemu cmdline involved:

-device megasas,id=3Dscsi0 \
-device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,lun=3D1 \
-drive file=3D/home/zhang/img/test.img,if=3Dnone,id=3Ddrive0,format=3Draw


Below is the syslog related to 'scsi|SCSI'

# dmesg | grep SCSI
[    0.392494] SCSI subsystem initialized
[    0.460666] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.706788] sd 1:0:0:0: [sda] Attached SCSI disk
# dmesg | grep scsi
[    0.511643] scsi host0: Avago SAS based MegaRAID driver
[    0.523302] scsi 0:2:0:0: Unexpected response from lun 1 while scanning,=
 scan aborted
[    0.540364] scsi host1: ata_piix
[    0.540780] scsi host2: ata_piix
[    0.702396] scsi 1:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5

When 'lun=3D1' is changed to 'lun=3D0', there is no issue.

Thank you very much!

Dongli Zhang
