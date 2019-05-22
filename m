Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A59C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAF521473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gOU66hrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfEVSbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:31:19 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:3346 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfEVSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:31:18 -0400
X-EEMSG-check-017: 226514867|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 May 2019 18:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558549853; x=1590085853;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZNFtgo98464FFumdNNSXhhawQQvya8ZlBcaJz1YwRnc=;
  b=gOU66hrmjouMMoO2raHA82rLkMS1jwmFYHaECa4RNVUgYrr4mBtgAva1
   gnNpugsCoplbe0VkFixRbh5Kc2W4BgOZ7pwVoyEJY2vhfn/vg1YkxCCdR
   BD56DHXcO3fkIle9oLN3LsPFXoN9MZ4oQ1a+AjSaAfqEbDiG5KtkuJsya
   t50Bjh+iQy28Vf/rXkltQhFXJaEN0tPB+59ECTLsQ8gUws3pcwnd70VB4
   PKGTIWrWvuLAnFSBX8y803nqLMyGsAXLfLtKxl7TeJG2Vdl/8l2oPsobJ
   BuJXnVLtIPzQoTq6tQp1D8rmXurCPMgxFXueJojFmsce3e10e1V2bHFVP
   g==;
X-IronPort-AV: E=Sophos;i="5.60,500,1549929600"; 
   d="scan'208";a="23997588"
IronPort-PHdr: =?us-ascii?q?9a23=3AE2bWgR1tnU0IVdJgsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWIvXxwZ3uMQTl6Ol3ixeRBMOHsqsC0rOM+Pm6BCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oRjPusUZnIduNKY8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXsxezAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDlKrhfa?=
 =?us-ascii?q?p660NHywo808pf55RKBbEFOv7zXVXxtNPABB8jLwO02/rnCMl61o4GXGKPAK?=
 =?us-ascii?q?CZPaPWvFKT6eIvJO6MZIARuDnjMfQq+/nujXohk18HYaapxYcXaGy/Hvl+IU?=
 =?us-ascii?q?WZZH3sgs0bEWcLpQozV+rqh0eHUTFNZna+RaU85is0CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWYmFGClaREXbnbomEQOkDZz6PIs97kzwESbigR5Yk1RGpqQD61r5nIf?=
 =?us-ascii?q?TP9y0GupLsysJ16/fQlR4s7zx0CdqS02WXQ2FzhGMISCc83Lpjrkxl1leDza?=
 =?us-ascii?q?94juRcFdxS4fNJTwg7OYffz+NkEdDyXBzOftOSRVa4TdWpHysxQsgyw9AQeU?=
 =?us-ascii?q?Z9HcutjhTZ0yqtGb8VmO/DOJth26TQzjDVOtp6znfcz6ogxw0iX9dIHW6rnK?=
 =?us-ascii?q?hy807UHYGf1w28nrq2dakDlAHE7n2O0XbG6ERaX1MhearCWn8baw3dqtGvtW?=
 =?us-ascii?q?3YSLr7MqgqKgtMz4a5L6JObtD4xQFdSOzLJMXVY2X3nXy5QxmP2OXfP8LRZ2?=
 =?us-ascii?q?wB0XCFWwA/mAcJ8CPDbFJvCw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BPAADXlOVc/wHyM5BdCBwBAQEEAQEHBAEBgVMFAQELA?=
 =?us-ascii?q?YFmKoFtKIQTlRV+iFCPCYEkA1QJAQEBAQEBAQEBNAECAQGEQAKCMSM2Bw4BA?=
 =?us-ascii?q?wEBAQQBAQEBAwEBbCiCOikBgmYBAQEBAgEjBBFBBQsLDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBF4JIP4F3BQ+oJHwzhUeDKIFGgQwoAYoygR4XeIEHgREnghsbNT6EH4Mvg?=
 =?us-ascii?q?lgEiyM7h22BJJNCCYIPghGQbwYbgh6UFIxdgSeWLAonNoEhKwgCGAghDzuCb?=
 =?us-ascii?q?IIbF4EBAQ6NKyMDMIEGAQGNaAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 May 2019 18:30:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4MIUnM3009971;
        Wed, 22 May 2019 14:30:50 -0400
Subject: Re: [RFC] Turn lockdown into an LSM
To:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190521224013.3782-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1905221203070.3967@namei.org>
 <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
 <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <14ed1f30-a1d0-f973-5c8c-241337c8fc09@tycho.nsa.gov>
Date:   Wed, 22 May 2019 14:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 1:08 PM, Andy Lutomirski wrote:
> On Wed, May 22, 2019 at 9:49 AM Matthew Garrett <mjg59@google.com> wrote:
>>
>> On Tue, May 21, 2019 at 7:40 PM James Morris <jmorris@namei.org> wrote:
>>> An LSM could also potentially implement its own policy for the hook.
>>
>> That was my plan. Right now the hook just gets an ASCII description of
>> the reason for the lockdown - that seems suboptimal for cases like
>> SELinux. What information would you want? My initial thinking was to
>> just have a stable enum of lockdown reasons that's in the UAPI headers
>> and then let other LSM tooling consume that, but I haven't spent
>> enough time with the internals of SELinux to know if there'd be a more
>> attractive solution.
> 
> I may be in the minority here, but I see this issue as a significant
> downside of making lockdown more flexible.  If we stick with just
> "this may violate integrity" and "this may violate confidentiality",
> then the ABI surface is nice and narrow.  If we start having a big
> uapi list of things that might qualify for lockdown, we need to worry
> about compatibility issues.
> 
> This isn't purely theoretical.  Lockdown has some interesting
> interactions with eBPF.  I don't want to be in a situation where v1 of
> lockdown has a few eBPF hooks, but a later update improves the eBPF vs
> lockdown interaction so that you can do more with eBPF on a locked
> down kernel.  But now any such change has to worry about breaking the
> lockdown LSM ABI.

I think we could keep the enum itself private to the kernel, and 
internally each security module could map the values to whatever 
permissions it wants to define.  SELinux itself has the ability to 
add/remove/re-arrange its permission definitions without breaking 
userspace/policy; they are dynamically mapped at policy load time. If a 
given permission doesn't exist in the loaded policy, there is a policy 
flag to control whether the policy should be rejected, or the permission 
should always be denied, or the permission should always be allowed. 
There is also support for an extensible set of "policy capabilities" to 
control whether new/changed permission checking logic for a given 
permission/operation should be enabled for that policy or if the kernel 
should continue using the older logic.

> And I still think it would be nice to have some credible use case for
> a more fine grained policy than just the tri-state.  Having a lockdown
> policy of "may not violate kernel confidentiality except using
> kprobes" may be convenient, but it's also basically worthless, since
> kernel confidentiality is gone.

I would expect that distros and users would have to make pragmatic 
tradeoffs in this area, and it would be nice if they could have a choice 
beyond all-or-nothing.  Do all of the interfaces being locked down 
expose the same degree of confidentiality or integrity risk?

> All this being said, I do see one big benefit for LSM integration:
> SELinux or another LSM could allow certain privileged tasks to bypass
> lockdown.

That seems to violate the intent of lockdown as I understood it, and 
turns security_is_locked_down() into a finer-grained capable() call.
Also, if I understand correctly, this could only be done if one were to 
disable the lockdown module in the lsm list, since the security 
framework will return non-zero (i.e. the operation is locked down) if 
any module that implements the hook returns non-zero; LSM is 
"restrictive". At that point, SELinux or the other LSM would be the sole 
arbiter of lockdown decisions.  SELinux or the other LSM also wouldn't 
have access to the kernel_locked_down level unless that was exported in 
some manner from the lockdown module.  Not sure how to compose these.

   This seems fine, except that there's potential nastiness
> where current->cred isn't actually a valid thing to look at in the
> current context.
> 
> So I guess my proposal is: use LSM, but make the hook very coarse
> grained: int security_violate_confidentiality(const struct cred *) and
> int security_violate_integrity(const struct cred *).

Not sure one can construct a useful policy at that granularity.
