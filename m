Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367946;
	bh=KEiIZz9xfVnTxdjO3KuNj0QnPOpROjgUVLibf7Lafis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XGALCCW5uyY4pUcdr18OZqJD+aL4YFo9v2CU76i9KVUghq82Zydk3NknVBTE5a5nl
	 yNm7/JVm2xFZYxBPIdRPxXkph+8z0av/9qKSR0Plm1XW2SANMtdkGd47L1mIn9kjG1
	 Xw1CbsM9hUpGEskqyh2bwxlTri88M76TXfNNLkWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfB1PcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbfB1PcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:32:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A7F218B0;
        Thu, 28 Feb 2019 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367935;
        bh=KEiIZz9xfVnTxdjO3KuNj0QnPOpROjgUVLibf7Lafis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gspTyG7XERiaNULLr7bGpqEa1T8kJ130sR6hH31VbOL43oWxDTnpaHOOmXeiU4nAK
         nUko47PfLhsQwPaImSWtfbeEYdIUIU8JrJ0iegwI4UVZLORPZxm4l4zELAJlSx3mf5
         oegnyLV5oedPNMAeACbeltzWHBUqh+11+io9jTXw=
Date:   Thu, 28 Feb 2019 16:32:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, kvm@vger.kernel.org,
        syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] kvm: properly check debugfs dentry before using it
Message-ID: <20190228153212.GH8481@kroah.com>
References: <0000000000007e10c50580aa7684@google.com>
 <0000000000006164d205825fb497@google.com>
 <20190226191932.GB218103@gmail.com>
 <20190228150805.GA31904@kroah.com>
 <a4ca3faa-5e57-b07a-5598-bde465bfebac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ca3faa-5e57-b07a-5598-bde465bfebac@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:14:50PM +0100, Paolo Bonzini wrote:
> On 28/02/19 16:08, Greg Kroah-Hartman wrote:
> > debugfs can now report an error code if something went wrong instead of
> > just NULL.  So if the return value is to be used as a "real" dentry, it
> > needs to be checked if it is an error before dereferencing it.
> > 
> > This is now happening because of ff9fb72bc077 ("debugfs: return error
> > values, not NULL").  syzbot has found a way to trigger multiple debugfs
> > files attempting to be created, which fails, and then the error code
> > gets passed to dentry_path_raw() which obviously does not like it.
> > 
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> > 
> > Paolo, this should be merged into 5.0-final, and if not there, then
> > 5.1-rc1 and then backported to 5.0 through the stable tree.  If you
> > want me to send this to Linus, I will be glad to do so.
> > 
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 585845203db8..076bc38963bf 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4044,7 +4044,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
> >  	}
> >  	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
> >  
> > -	if (kvm->debugfs_dentry) {
> > +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
> >  		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
> >  
> >  		if (p) {
> > 
> 
> Sure, go ahead.
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Wonderful, will do so right now, thanks!

greg k-h
