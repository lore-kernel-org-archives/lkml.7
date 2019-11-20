Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA95C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD56D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKTUft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:35:49 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:35312 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKTUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:35:49 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXWhV-0003lv-28; Wed, 20 Nov 2019 20:35:45 +0000
Message-ID: <1eb03d47afc38cd01d17988cf170b14066569bde.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 12/16] hostfs: pass 64-bit timestamps to/from
 user space
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 20 Nov 2019 20:35:44 +0000
In-Reply-To: <fff201b0d21a8ba775eb1d201e083ba96f8ff6f1.camel@codethink.co.uk>
References: <20191108213257.3097633-1-arnd@arndb.de>
         <20191108213257.3097633-13-arnd@arndb.de>
         <fff201b0d21a8ba775eb1d201e083ba96f8ff6f1.camel@codethink.co.uk>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 20:30 +0000, Ben Hutchings wrote:
> On Fri, 2019-11-08 at 22:32 +0100, Arnd Bergmann wrote:
> > The use of 'struct timespec' is deprecated in the kernel, so we
> > want to avoid the conversions from/to the proper timespec64
> > structure.
> > 
> > On the user space side, we have a 'struct timespec' that is defined
> > by the C library and that will be incompatible with the kernel's
> > view on 32-bit architectures once they move to a 64-bit time_t,
> > breaking the shared binary layout of hostfs_iattr and hostfs_stat.
> > 
> > This changes the two structures to use a new hostfs_timespec structure
> > with fixed 64-bit seconds/nanoseconds for passing the timestamps
> > between hostfs_kern.c and hostfs_user.c. With a new enough user
> > space side, this will allow timestamps beyond year 2038.
> [...]
> 
> The "user-space" side has a structure assignment in set_attr():
> 
> 	if (attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)) {
> 		err = stat_file(file, &st, fd);
> 		attrs->ia_atime = st.atime;
> 		attrs->ia_mtime = st.mtime;
> 		if (err != 0)
> 			return err;
> 	}
> 
> which will also need to be updated for this type change.

Sorry, I'm confused, this looks fine.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

