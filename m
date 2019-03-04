Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55397206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfCDQtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:49:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbfCDQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:49:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24GkSe0020646
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 11:49:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r157vr36y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:49:34 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Mar 2019 16:49:32 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 16:49:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24GnR8i58785998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 16:49:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D80AB4C040;
        Mon,  4 Mar 2019 16:49:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED0BE4C04A;
        Mon,  4 Mar 2019 16:49:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 16:49:26 +0000 (GMT)
Subject: Re: [PATCH] vfs: Move kernel_read_file() to fs/read_write.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Mar 2019 11:49:16 -0500
In-Reply-To: <12096.1551716540@warthog.procyon.org.uk>
References: <1551715930.10911.468.camel@linux.ibm.com>
         <155171231301.4764.5429281379303710262.stgit@warthog.procyon.org.uk>
         <12096.1551716540@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030416-0016-0000-0000-0000025DAEDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030416-0017-0000-0000-000032B82D2E
Message-Id: <1551718156.10911.473.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 16:22 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > > Move kernel_read_file() to fs/read_write.c and out of fs/exec.c as it's not
> > > actually used by anything in the execve subsystem.
> > 
> > All files being opened by the kernel should be calling one of these
> > helper routines.  Has that changed?
> 
> prepare_binprm() uses kernel_read() and has done since at least 2014.  The
> binfmt drivers also use kernel_read().
> 
> Since kernel_read_file() is used by a bunch of things that aren't exec, even
> if we switch exec to it, it should probably still go in fs/read_write.c since
> it seems generic.

Oh, commit bdd1d2d3d251 ("fs: fix kernel_read prototype") moved
kernel_read() to fs/read_write.c without moving the helpers.
 Definitely makes sense to move the helpers.  Please include a
reference to the commit in this patch. 

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

