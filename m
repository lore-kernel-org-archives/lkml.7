Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEDB22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PR6TPxJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGZSat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:30:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37531 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGZSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:30:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so24898772pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cJ4z2P+szfKPD/+W44RYswMnwdJpu0con0N06FUapqc=;
        b=PR6TPxJd9R1dOURlef11XecrEedDn92M3WMh17SWdO7bsrb6cRshsw7KDpOPp9s9vJ
         FYRClfphKPyjkcuI2tAZriIs3yxRBFbuyTaP1YWmoASw95qxsRMJGZ6AB/ayE3ICcmdn
         oMo5fNNgR4KQ2JFI6mbYik++MlADACgesquk5Y0PW57GPoe3m31pzxSJ6liVPjdZ8KOO
         FmwuMSaxJtDMr1090sNB/opdGBtYBJ1NScaYXHmxC32JjTG+xm1+7zuRuan9DdBb663F
         mvWmCu9lyR/coEYmjPAIUjI2yGpLiK+7dUGhDk29pV1LKV1/B/Y1opDf9Sj05TYLjP3L
         nG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cJ4z2P+szfKPD/+W44RYswMnwdJpu0con0N06FUapqc=;
        b=RkimXIgD/P9y8UO0vS8h3iv6BQmVdZtGyYj3F2iiIhXP2gZfgI42TDlAsT0a2Vmv0C
         VF50RGErp0coGB36gWkIbXhNIf9OJEbVFmEuBDqbdzoXLcKyzjzhgwKNK/xhwvazLJX0
         e/L9ihtAj2doS7g/Pl8g4zH2W5p83XmmvF4nG9VbezF61v8LJsRusbkHhPITZmxCA8iv
         jfTylTjFa+7uaaea8YAlSAudPiYQcMLofcSb3xSAS6/TPyYMWcE64YNC3x/52qu1DB0V
         kmPlEPFTnBXCJgGGjP6wkjjN8xjRj+ndmDICRwb7sS5BSil7U4aX3u9WWO2uN0JjyHYQ
         etXw==
X-Gm-Message-State: APjAAAXwmr4Y6x8Zr1NBzElnjRnyCa39TUps5Rtq68SZxh84Szuw3drD
        TBpbskKqK099VS/+9sEpEHc=
X-Google-Smtp-Source: APXvYqwHiGxIZZdpCIUMNCazy6wufMzinuVfJ6PAxAqI1hr1FIdU5KimcQnoXHa+Ycr9kZy6xy6/kA==
X-Received: by 2002:a65:6294:: with SMTP id f20mr95138419pgv.349.1564165847849;
        Fri, 26 Jul 2019 11:30:47 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id d6sm47190235pgf.55.2019.07.26.11.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:30:47 -0700 (PDT)
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20190724195719.218307-1-salyzyn@android.com>
 <20190724195719.218307-4-salyzyn@android.com>
 <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
 <af254162-10bf-1fc5-2286-8d002a287400@android.com>
 <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
 <35b70147-25ad-4c29-3972-418ebee5e7b8@android.com>
 <CAOQ4uxg8k=4D5_VEBy61PwBo+2pCCakUPw3uCar2oQpi3yaLmA@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <f56cd45d-2926-094e-7f02-e2ca972214ba@android.com>
Date:   Fri, 26 Jul 2019 11:30:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg8k=4D5_VEBy61PwBo+2pCCakUPw3uCar2oQpi3yaLmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 10:04 PM, Amir Goldstein wrote:
> On Thu, Jul 25, 2019 at 7:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> On 7/25/19 8:43 AM, Amir Goldstein wrote:
>>> On Thu, Jul 25, 2019 at 6:03 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>>> On 7/24/19 10:48 PM, Amir Goldstein wrote:
>>>>> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>>>>> Because of the overlayfs getxattr recursion, the incoming inode fails
>>>>>> to update the selinux sid resulting in avc denials being reported
>>>>>> against a target context of u:object_r:unlabeled:s0.
>>>>> This description is too brief for me to understand the root problem.
>>>>> What's wring with the overlayfs getxattr recursion w.r.t the selinux
>>>>> security model?
>>>> __vfs_getxattr (the way the security layer acquires the target sid
>>>> without recursing back to security to check the access permissions)
>>>> calls get xattr method, which in overlayfs calls vfs_getxattr on the
>>>> lower layer (which then recurses back to security to check permissions)
>>>> and reports back -EACCES if there was a denial (which is OK) and _no_
>>>> sid copied to caller's inode security data, bubbles back to the security
>>>> layer caller, which reports an invalid avc: message for
>>>> u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for
>>>> the lower filesystem target). The blocked access is 100% valid, it is
>>>> supposed to be blocked. This does however result in a cosmetic issue
>>>> that makes it impossible to use audit2allow to construct a rule that
>>>> would be usable to fix the access problem.
>>>>
>>> Ahhh you are talking about getting the security.selinux.* xattrs?
>>> I was under the impression (Vivek please correct me if I wrong)
>>> that overlayfs objects cannot have individual security labels and
>> They can, and we _need_ them for Android's use cases, upper and lower
>> filesystems.
>>
>> Some (most?) union filesystems (like Android's sdcardfs) set sepolicy
>> from the mount options, we did not need this adjustment there of course.
>>
>>> the only way to label overlayfs objects is by mount options on the
>>> entire mount? Or is this just for lower layer objects?
>>>
>>> Anyway, the API I would go for is adding a @flags argument to
>>> get() which can take XATTR_NOSECURITY akin to
>>> FMODE_NONOTIFY, GFP_NOFS, meant to avoid recursions.
>> I do like it better (with the following 7 stages of grief below), best
>> for the future.
>>
>> The change in this handler's API will affect all filesystem drivers
>> (well, my change affects the ABI, so it is not as-if I saved the world
>> from a module recompile) touching all filesystem sources with an even
>> larger audience of stakeholders. Larger audience of stakeholders, the
>> harder to get the change in ;-/. This is also concerning since I would
>> like this change to go to stable 4.4, 4.9, 4.14 and 4.19 where this
>> regression got introduced. I can either craft specific stable patches or
>> just let it go and deal with them in the android-common distributions
>> rather than seeking stable merged down. ABI/API breaks are a problem for
>> stable anyway ...
>>
> Use the memalloc_nofs_save/restore design pattern will avoid all that
> grief.
> As a matter of fact, this issue could and should be handled inside security
> subsystem without bothering any other subsystem.
> LSM have per task context right? That context could carry the recursion
> flags to know that the getxattr call is made by the security subsystem itself.
> The problem is not limited to union filesystems.
> In general its a stacking issue. ecryptfs is also a stacking fs, out-of-tree
> shiftfs as well. But it doesn't end there.
> A filesystem on top of a loop device inside another filesystem could
> also maybe result in security hook recursion (not sure if in practice).
>
> Thanks,
> Amir.

Good point, back to Stephen Smalley?

There are four __vfs_getxattr calls inside security, not sure I see any 
natural way to determine the recursion in security/selinux I can 
beg/borrow/steal from; but I get the strange feeling that it is better 
to detect recursion in __vfs_getxattr in this manner, and switch out 
checking in vfs_getxattr since it is localized to just fs/xattr.c. 
selinux might not be the only user of __vfs_getxattr nature ...

I have implemented and tested the solution where we add a flag to the 
.get method, it works. I would be tempted to submit that instead in case 
someone in the future can imagine using that flag argument to solve 
other problem(s) (if you build it, they will come).

<flips coin>

Will add a new per-process flag that __vfs_getxattr and vfs_getxattr 
plays with and see how it works and what it looks like.

Sincerely -- Mark Salyzyn

