Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DAC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308169;
	bh=m7lFOUM4c3MvB1yjd1lFh6kMBfBqzE5Tns8BLLH1vqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M2Q9nS4aMd90/7onmAf6QaAKBa5/mcoeobM5qIMyZtjyO6ktbPGIlDNTTfz7/8sup
	 0FXUGWI4T+bY8+bVGGkXcrUnkwzyZU7X7720Yaf823sr14js5HOquynq0YCAnSOX4e
	 SgM0vyS/wbDlx0pP611tk+XivdqRVP2p9viL0+Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDCQQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:16:08 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEC8206B7;
        Wed,  3 Apr 2019 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308167;
        bh=m7lFOUM4c3MvB1yjd1lFh6kMBfBqzE5Tns8BLLH1vqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuBzjPPXVtjwxtWsz6k18Ic1+FJN26PrjM9FBGcDWazbD2xnjSJYVn8xl2Q+7g9oX
         gE7VuT2InZG3ub4Hu4c5c33SFiquKoWW2hQDltaoBlkukf5L82xaKmj92HBmJtnhnG
         oxgTdZI3pdII8uEz4+b0JqAb3AFsS+1eICwkC/Vc=
Date:   Wed, 3 Apr 2019 12:16:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH AUTOSEL 4.19 40/57] kvm: properly check debugfs dentry
 before using it
Message-ID: <20190403161606.GB16241@sasha-vm>
References: <20190330012854.32212-1-sashal@kernel.org>
 <20190330012854.32212-40-sashal@kernel.org>
 <20190330054350.GB23655@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190330054350.GB23655@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 06:43:50AM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 29, 2019 at 09:28:33PM -0400, Sasha Levin wrote:
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> [ Upstream commit 8ed0579c12b2fe56a1fac2f712f58fc26c1dc49b ]
>>
>> debugfs can now report an error code if something went wrong instead of
>> just NULL.  So if the return value is to be used as a "real" dentry, it
>> needs to be checked if it is an error before dereferencing it.
>>
>> This is now happening because of ff9fb72bc077 ("debugfs: return error
>> values, not NULL").  syzbot has found a way to trigger multiple debugfs
>> files attempting to be created, which fails, and then the error code
>> gets passed to dentry_path_raw() which obviously does not like it.
>>
>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>> Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  virt/kvm/kvm_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index c436d95fd7aa..fb74f994cb63 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3912,7 +3912,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>  	}
>>  	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
>>
>> -	if (kvm->debugfs_dentry) {
>> +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
>>  		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
>>
>>  		if (p) {
>> --
>> 2.19.1
>>
>
>Same thing here, this was a 5.0-only thing, no need for it to be
>backported, please drop it from all trees.

Dropped, thanks!

--
Thanks,
Sasha
