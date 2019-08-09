Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EBB2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dGJHoLsJ";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eYLwW1nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406018AbfHIJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:25:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHIJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:25:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x799P9N0022012;
        Fri, 9 Aug 2019 09:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=u6x3As4MfXMR9e0DcE2E84qHWZeCd3YYNsZEqIVy7JI=;
 b=dGJHoLsJeMw/LWqkhHNg5bQw8vsxKHMMxnPMOFgS5jJC0t+vdOk5seVj1XdGpTkpyE0s
 pz90pdXmmEF1ACv8tSLFCnjbc4UGMsYsTqwp6ZH/bvXx2T+Q2eeezI03DnXzU1ntQOwW
 ipyz5mr4Re7aXTq0+1P+x4+zQA9h6LxDOPJjepZPdFPAYmHzh+AMBf1O0liali8aq2SU
 TYwXT6V1y+pOQzQIE+JHzNkeMy2XE22p1949uJYpK9VH/jIx8kmunylLYGRp1p5G9NPd
 wpGiwncqgPCwXvo09uQjd26L9bX6VNTdcvjTO04W7VPSHNKq1OEqHCrCp8s5oYSmYEKK ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=u6x3As4MfXMR9e0DcE2E84qHWZeCd3YYNsZEqIVy7JI=;
 b=eYLwW1nYy+4c7mCmQNyEKl5skNe6Q46zP6oeUYCdlMeVkyaJ+glRKyPWyW8gtfZRDXc3
 fOC7tG+9qzVbBvnYnWa3t2HyP2iQ8Nl4yfE/de18ZMIiwfKnRno+cWnW6XtD1EAjMxPi
 J5hg7vVeMWPd0sB8Ou/3AFcbt+zB+qrNOD5iVxksWGHmJYzKhwCMdonHcclYRRLxPLRT
 ctC5qBvrX8LQTEkTE+4Y3OlEjKAlLpozFjypLMNlCvJHTyt7ofRQ2zicdF9Sn/f4VVG0
 Q4dJ99i4i1COlU61/554g2Xa2yGMW2WAYREoCUAZ3T1OECTwksSw9+MAX7zzn4a8Kwb6 YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u8hgp6e6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 09:25:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x799NWab024056;
        Fri, 9 Aug 2019 09:25:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u8pj8w5b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 09:25:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x799PPeQ022647;
        Fri, 9 Aug 2019 09:25:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 02:25:25 -0700
Date:   Fri, 9 Aug 2019 12:25:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     devel@driverdev.osuosl.org, kernel-team@android.com,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 1/2] binder: Add default binder devices through
 binderfs when configured
Message-ID: <20190809092516.GQ1974@kadam>
References: <20190806184007.60739-1-hridya@google.com>
 <20190806184007.60739-2-hridya@google.com>
 <20190807110204.GL1974@kadam>
 <CA+wgaPNSWbJi3feygHixJX5cLUnQFH0tVSnBrrGQYtE7LUZPzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wgaPNSWbJi3feygHixJX5cLUnQFH0tVSnBrrGQYtE7LUZPzQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:51:46AM -0700, Hridya Valsaraju wrote:
> On Wed, Aug 7, 2019 at 4:02 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Tue, Aug 06, 2019 at 11:40:05AM -0700, Hridya Valsaraju wrote:
> > > @@ -467,6 +466,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> > >       int ret;
> > >       struct binderfs_info *info;
> > >       struct inode *inode = NULL;
> > > +     struct binderfs_device device_info = { 0 };
> > > +     const char *name;
> > > +     size_t len;
> > >
> > >       sb->s_blocksize = PAGE_SIZE;
> > >       sb->s_blocksize_bits = PAGE_SHIFT;
> > > @@ -521,7 +523,24 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> > >       if (!sb->s_root)
> > >               return -ENOMEM;
> > >
> > > -     return binderfs_binder_ctl_create(sb);
> > > +     ret = binderfs_binder_ctl_create(sb);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     name = binder_devices_param;
> > > +     for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > > +             strscpy(device_info.name, name, len + 1);
> > > +             ret = binderfs_binder_device_create(inode, NULL, &device_info);
> > > +             if (ret)
> > > +                     return ret;
> >
> > We should probably clean up before returning...  The error handling code
> > would probably be tricky to write though and it's not super common.
> 
> Thank you for taking a look Dan. Did you mean cleaning up the default
> devices that were already created? They will actually be cleaned up by
> binderfs_evict_inode() during the super block's cleanup since the
> mount operation will fail due to an error here.

Yeah.  I meant the binderfs_binder_device_create() from previous
iterations through this loop.

Good to know that it's handled.  Thanks for taking the time to look at
this.

regards,
dan carpenter

