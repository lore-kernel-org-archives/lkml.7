Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A2C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA55B20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEBQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:58:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53374 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfEBQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:58:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hMF2a-0003Sx-Au; Thu, 02 May 2019 16:58:36 +0000
Date:   Thu, 2 May 2019 17:58:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        vgoyal@redhat.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 3/4] add kexec_cmdline used to ima
Message-ID: <20190502165836.GX23075@ZenIV.linux.org.uk>
References: <20190429214743.4625-1-prsriva02@gmail.com>
 <20190429214743.4625-4-prsriva02@gmail.com>
 <1556815955.4134.78.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556815955.4134.78.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:52:35PM -0400, Mimi Zohar wrote:
> On Mon, 2019-04-29 at 14:47 -0700, Prakhar Srivastava wrote:
> > From: Prakhar Srivastava <prsriva02@gmail.com>

> kexec doesn't really know or care about IMA.  Other than the IMA call,
> itself, nothing should be added to kexec files.  As mentioned in 1/4,
> the IMA hook would be named something like ima_kexec_cmdline().

> > +	f = fdget(kernel_fd);
> > +	if (!f.file)
> > +		goto out;
> > +
> > +	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
> > +			ARRAY_SIZE(delimiter)) - 1;
> > +
> > +	buf = kzalloc(size, GFP_KERNEL);
> > +	if (!buf)
> > +		goto out;
> > +
> > +	memcpy(buf, f.file->f_path.dentry->d_name.name,
> > +		f.file->f_path.dentry->d_name.len);
> > +	memcpy(buf + f.file->f_path.dentry->d_name.len,
> > +		delimiter, ARRAY_SIZE(delimiter) - 1);
> > +	memcpy(buf + f.file->f_path.dentry->d_name.len +
> > +		ARRAY_SIZE(delimiter) - 1,
> > +		cmdline_ptr, cmdline_len - 1);

Another thing is that it's so obviously racy, it's not even funny.
Consider what rename(2) in parallel will do to that.
