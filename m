Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A188C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C6520693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="G4cx8p8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfG3QBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:01:31 -0400
Received: from usfb19pa15.eemsg.mail.mil ([214.24.26.86]:5291 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfG3QBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:01:30 -0400
X-EEMSG-check-017: 243885150|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jul 2019 15:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1564502106; x=1596038106;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/9O7vf+1jngEFyaSkYlMr13z5HQv3xT4qJnmyI9c4m0=;
  b=G4cx8p8ezBVS9S+1K3TMvXpRgq8hCZ0ULFcO73Ut2PMwYtF7abaIupXd
   CXUXG9t4jmA9gQpC+UuScQRGhLi517i3eRfwGQeUons1YmTmtN+W69fPm
   YEIhOO+gY9xmv0ND1Xj3hZP1xtDJ096o2XUOvh8CN4po6jHxbbhB6vTWU
   cK0wa4v9RHx2JJ0C/qj6c7cMEI6cL7Td3jndE2YLUa12ytD6vDMoFHBBV
   qjbKrchJaGmMR4yhjPJQ0K1BkD47TmQgLJKZGLO5lOW69F5eukIe9UGFo
   o/BK6erfWe7Z2nB0AxRmL8/3qyNtEMtx99uUaM9Rvjz7Zb/NUKUBsqhEv
   A==;
X-IronPort-AV: E=Sophos;i="5.64,327,1559520000"; 
   d="scan'208";a="26241276"
IronPort-PHdr: =?us-ascii?q?9a23=3AVZpdlhaiqmA1MCEa7V7k+cj/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsi7bR7h7PlgxGXEQZ/co6odzbaP6eaxAidRuN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6twHcu8cZjYZmN6o61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jYirjheb?=
 =?us-ascii?q?Z86k9cyQo11t1Q/ZRUBawbIPL0W0/+qcbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLndsVqJ5uI1IeSBao4VuDLmJvgq4v7hl345mVsHcaa12psXbWiyHu56LE?=
 =?us-ascii?q?WBfXrsntABHH8Ovgo/SuzqlVKDXSdQZ3msRaI84C80CIa9AIfdSYCinqaB0D?=
 =?us-ascii?q?24HpJIfGBGDE6DEXPye4WDQfcMZzqYItV9nTwcSbihV4gh2AmttADk0bpnKP?=
 =?us-ascii?q?Tb+ikBuZL/ytd6/ejTmAoo+jxyEsudyWaNT2BpkW8SWzA226V/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNMUwc6Nprcz+thC93pQQLAf8mGSEy4Tdq7ADE9VNIxw8IWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INi7OLA4Y0/bnC0HjtPMt9z3jH1K87g1kgXMRPKXWshr?=
 =?us-ascii?q?Rj+AjLG47Jj0KZmr60daQT2y7M9H2MzW6VsUFCTgF/TKXFUmoDZkfMsdv54U?=
 =?us-ascii?q?bCRae0Cbs7KgtB1dKCKqxSZ9L3llpGRensN8nAbGKrnme9HhmJxraNbIrxYG?=
 =?us-ascii?q?Ud3SLdCE4enw8P+naGMBA0Bj29rGLGEDxuCVXvblv28eZjtXO7SEs0wBuSb0?=
 =?us-ascii?q?B61rq1/BAVheaGRPwOwL0Lojoupy9zHFan0NLcE8CAqBZ5fKVAfdM9509K1W?=
 =?us-ascii?q?bYtwx7I5yhILluhkMYcwR2uEPu0Rt3Cp5bnMg0o3Ml0hByJbib0FxfbTOY24?=
 =?us-ascii?q?7/OrnNJmn15hCvZLbc2kvC39aO5qcP9PM4pk3nvAGoEEoi7npm38BI3Hub+p?=
 =?us-ascii?q?rHFxQSUZ3vXUYt7RR6pK/VYjM754zK0X1gK660siXN24FhOOxw7x+6fJ9kOa?=
 =?us-ascii?q?eVBh70W5kBDsy/Ov0ss1GvYggDPewU/6kxaYfuXv6HwuaEO+Jshy6rjGIPtI?=
 =?us-ascii?q?l401jTrCt4YuHN1pcBhfqf213UeS37iQKars3vmY1CLQoXF267xDmsUJVdfY?=
 =?us-ascii?q?VubI0LDiGoOMTxydJg0c2+E0VE/UKuUgtVkPSifgCfOhmkhlxd?=
X-IPAS-Result: =?us-ascii?q?A2CmCgA0Z0Bd/wHyM5BlHQEBBQEHBQGBZ4FtKoE+ATIqh?=
 =?us-ascii?q?B6RG04FBoEJCCWJYpEbCQEBAQEBAQEBATQBAgEBhEACgkEjOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBBQEBbIUqgjopAYJnAQUjFTwFEAsYAgImAgJXBgEMBgIBAReCSD+BdxSsW?=
 =?us-ascii?q?IEyhUiDMYFIgQwoh2+DcRd4gQeBOAyBYUk1PoQdgzKCWASMASGCJ4YwlgQJg?=
 =?us-ascii?q?hyCH5FxBhuCLocljj4tjRCBMZg4IYFYKwgCGAghD4Mngk4Xjj0jAzCBBgEBi?=
 =?us-ascii?q?x+CUgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Jul 2019 15:55:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6UFt0t0028645;
        Tue, 30 Jul 2019 11:55:00 -0400
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
To:     Mark Salyzyn <salyzyn@android.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20190724195719.218307-1-salyzyn@android.com>
 <20190724195719.218307-4-salyzyn@android.com>
 <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
 <af254162-10bf-1fc5-2286-8d002a287400@android.com>
 <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
 <35b70147-25ad-4c29-3972-418ebee5e7b8@android.com>
 <CAOQ4uxg8k=4D5_VEBy61PwBo+2pCCakUPw3uCar2oQpi3yaLmA@mail.gmail.com>
 <f56cd45d-2926-094e-7f02-e2ca972214ba@android.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e83ceef6-70ae-fd9e-2087-50baf2fbd402@tycho.nsa.gov>
Date:   Tue, 30 Jul 2019 11:55:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f56cd45d-2926-094e-7f02-e2ca972214ba@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 2:30 PM, Mark Salyzyn wrote:
> On 7/25/19 10:04 PM, Amir Goldstein wrote:
>> On Thu, Jul 25, 2019 at 7:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>> On 7/25/19 8:43 AM, Amir Goldstein wrote:
>>>> On Thu, Jul 25, 2019 at 6:03 PM Mark Salyzyn <salyzyn@android.com> 
>>>> wrote:
>>>>> On 7/24/19 10:48 PM, Amir Goldstein wrote:
>>>>>> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn 
>>>>>> <salyzyn@android.com> wrote:
>>>>>>> Because of the overlayfs getxattr recursion, the incoming inode 
>>>>>>> fails
>>>>>>> to update the selinux sid resulting in avc denials being reported
>>>>>>> against a target context of u:object_r:unlabeled:s0.
>>>>>> This description is too brief for me to understand the root problem.
>>>>>> What's wring with the overlayfs getxattr recursion w.r.t the selinux
>>>>>> security model?
>>>>> __vfs_getxattr (the way the security layer acquires the target sid
>>>>> without recursing back to security to check the access permissions)
>>>>> calls get xattr method, which in overlayfs calls vfs_getxattr on the
>>>>> lower layer (which then recurses back to security to check 
>>>>> permissions)
>>>>> and reports back -EACCES if there was a denial (which is OK) and _no_
>>>>> sid copied to caller's inode security data, bubbles back to the 
>>>>> security
>>>>> layer caller, which reports an invalid avc: message for
>>>>> u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for
>>>>> the lower filesystem target). The blocked access is 100% valid, it is
>>>>> supposed to be blocked. This does however result in a cosmetic issue
>>>>> that makes it impossible to use audit2allow to construct a rule that
>>>>> would be usable to fix the access problem.
>>>>>
>>>> Ahhh you are talking about getting the security.selinux.* xattrs?
>>>> I was under the impression (Vivek please correct me if I wrong)
>>>> that overlayfs objects cannot have individual security labels and
>>> They can, and we _need_ them for Android's use cases, upper and lower
>>> filesystems.
>>>
>>> Some (most?) union filesystems (like Android's sdcardfs) set sepolicy
>>> from the mount options, we did not need this adjustment there of course.
>>>
>>>> the only way to label overlayfs objects is by mount options on the
>>>> entire mount? Or is this just for lower layer objects?
>>>>
>>>> Anyway, the API I would go for is adding a @flags argument to
>>>> get() which can take XATTR_NOSECURITY akin to
>>>> FMODE_NONOTIFY, GFP_NOFS, meant to avoid recursions.
>>> I do like it better (with the following 7 stages of grief below), best
>>> for the future.
>>>
>>> The change in this handler's API will affect all filesystem drivers
>>> (well, my change affects the ABI, so it is not as-if I saved the world
>>> from a module recompile) touching all filesystem sources with an even
>>> larger audience of stakeholders. Larger audience of stakeholders, the
>>> harder to get the change in ;-/. This is also concerning since I would
>>> like this change to go to stable 4.4, 4.9, 4.14 and 4.19 where this
>>> regression got introduced. I can either craft specific stable patches or
>>> just let it go and deal with them in the android-common distributions
>>> rather than seeking stable merged down. ABI/API breaks are a problem for
>>> stable anyway ...
>>>
>> Use the memalloc_nofs_save/restore design pattern will avoid all that
>> grief.
>> As a matter of fact, this issue could and should be handled inside 
>> security
>> subsystem without bothering any other subsystem.
>> LSM have per task context right? That context could carry the recursion
>> flags to know that the getxattr call is made by the security subsystem 
>> itself.
>> The problem is not limited to union filesystems.
>> In general its a stacking issue. ecryptfs is also a stacking fs, 
>> out-of-tree
>> shiftfs as well. But it doesn't end there.
>> A filesystem on top of a loop device inside another filesystem could
>> also maybe result in security hook recursion (not sure if in practice).
>>
>> Thanks,
>> Amir.
> 
> Good point, back to Stephen Smalley?
> 
> There are four __vfs_getxattr calls inside security, not sure I see any 
> natural way to determine the recursion in security/selinux I can 
> beg/borrow/steal from; but I get the strange feeling that it is better 
> to detect recursion in __vfs_getxattr in this manner, and switch out 
> checking in vfs_getxattr since it is localized to just fs/xattr.c. 
> selinux might not be the only user of __vfs_getxattr nature ...
> 
> I have implemented and tested the solution where we add a flag to the 
> .get method, it works. I would be tempted to submit that instead in case 
> someone in the future can imagine using that flag argument to solve 
> other problem(s) (if you build it, they will come).
> 
> <flips coin>
> 
> Will add a new per-process flag that __vfs_getxattr and vfs_getxattr 
> plays with and see how it works and what it looks like.

As you say, SELinux is not the only user of __vfs_getxattr; in addition 
to the other security modules, there is the integrity/evm subsystem and 
ecryptfs.  Further, __vfs_getxattr does not merely skip 
LSM/SELinux-related processing; it also skips xattr_permission().  As 
such, I don't believe this is something that can be solved entirely 
within the security subsystem.

Not excited about a process flag to implicitly disable LSM/SELinux and 
other security-related processing on a code path; potential for abuse is 
high.
