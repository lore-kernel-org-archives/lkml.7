Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AD7218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374253;
	bh=QLGDfWIce/E7MTsvYlDTFHRKkYayZZdgX8XtvRq8dJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zRqto559RAHU1N3GwPWTyB3d+aaDY0y94oiMUpePbxlUIW2/dCKjyHuLf27KhMd+7
	 9hxKNFxbSfr064RgahiFyp4GJBUOBJi3fH8tKLsX00SbNPAPwEtV+OVfEyaTKCnBz/
	 USoBjgKb0T+tyJiMkuKtX+gWRdBqGLweuTfsQKWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfB1RRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfB1RRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:17:31 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD2A20857;
        Thu, 28 Feb 2019 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374250;
        bh=QLGDfWIce/E7MTsvYlDTFHRKkYayZZdgX8XtvRq8dJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDJpDo7o2VcNtpfWF2czCFRTfAjq8hXwS2s7uiSoZFcfrE2HxZc6wYMc0a0vvdbUi
         o3Y7FahfbyW8N0JIa0HfkK+ju+Dt4/ygXtIu3JsLowB69ysWtS5DOjjzUseLCc1dwr
         KgLx9Soapm23W+/aTH3+ZxLM9RtgHoOGyGoIIHC0=
Date:   Thu, 28 Feb 2019 09:17:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org,
        syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] kvm: properly check debugfs dentry before using it
Message-ID: <20190228171727.GA663@sol.localdomain>
References: <20190228153437.GI8481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228153437.GI8481@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:34:37PM +0100, Greg Kroah-Hartman wrote:
> debugfs can now report an error code if something went wrong instead of
> just NULL.  So if the return value is to be used as a "real" dentry, it
> needs to be checked if it is an error before dereferencing it.
> 
> This is now happening because of ff9fb72bc077 ("debugfs: return error
> values, not NULL").  syzbot has found a way to trigger multiple debugfs
> files attempting to be created, which fails, and then the error code
> gets passed to dentry_path_raw() which obviously does not like it.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Linus, this should go in before 5.0-final is out, as it resolves a
> problem found by syzbot.  Paolo has given his ack for me to send this
> directly to you.  If you want this in [GIT PULL] format, I can do that
> as well.
> 
>  virt/kvm/kvm_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4044,7 +4044,7 @@ static void kvm_uevent_notify_change(uns
>  	}
>  	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
>  
> -	if (kvm->debugfs_dentry) {
> +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
>  		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
>  
>  		if (p) {

So what about the other checks of kvm->debugfs_dentry, in
kvm_destroy_vm_debugfs() and kvm_create_vcpu_debugfs()?

- Eric
