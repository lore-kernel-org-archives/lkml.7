Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05708C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E7E20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jIGYWByc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfEVUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:03:37 -0400
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:20479 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfEVUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:03:30 -0400
X-EEMSG-check-017: 55529339|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 May 2019 20:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558555407; x=1590091407;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wFvaJbIE08TONbZxuGrf78b10I67o7m3mEsu4a88MKU=;
  b=jIGYWBycP2Zchb+OmMKA78DoPFCw6ia70cVM7hZlDsP6oFK9SDRPfRkb
   fOkEB3Tn6c9JBhvalEuN1PSNoUW4222BXS0899o2g1RQX4whEtLk/VjO9
   zodjLUB9GsumTcPJyvdZpvCFxa6239dTXxTE0gYhsp/ns33dluhBdvdqO
   1Y019ujtgAJgyDKfgEnVC2UXdi1695gRyjF9UwVwpVCcDQ2HrCCTyIYVm
   A3guSa5zOw+Qh8YydA+Pp/wyUK49/ddYqRwFu4z9QNTUNU85k9W0nWnaC
   q0ZKz16oVb6qWIki1VWZLLQPO/pR+Osrcy3EPXBPCzRdbxN3/wKAjTana
   g==;
X-IronPort-AV: E=Sophos;i="5.60,500,1549929600"; 
   d="scan'208";a="28061893"
IronPort-PHdr: =?us-ascii?q?9a23=3A/h6xVhNRCgFgTXKtOV8l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z+pcbcNUDSrc9gkEXOFd2Cra4d0qyP6vqrADBdqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAndq9cajYR/Jqs+yh?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHDIy8dY8PBPcfM+heoYf2ul8CoQK+CASoAe/izCJDiH3r0q0gy+?=
 =?us-ascii?q?kvDB/I3AIgEdwNvnrbotr6O6UOXu6616TI0TfOYulK1Tvh5oXFcBYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGR7ZjlqOsYzlPy2a1uIQuGaG6upvT+avi2o5pABxvzOiwdwshZ?=
 =?us-ascii?q?TSho8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQslp?=
 =?us-ascii?q?sTrUvDHij2lF/wjKCKbUUr5vKk6+HmYrXivpOcNol0hR/iMqk2h8CyDus1Ph?=
 =?us-ascii?q?IOUmSG4+iwyrLu8VPjTLlXlvE2l7PWsJHeJcQVvK65BApV35446xmiFDery8?=
 =?us-ascii?q?gYnHkbI1JFfxKLlY7pO0rUL/ziAve/hEqsnC9xx//aJr3hHonNLn/bnbfjeL?=
 =?us-ascii?q?Z97FRcyBAyzdBE/J9UDKsOIPftVU/wrtDYCQU5MwOsyeb9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBNKPSrEOI5uU0LumPeoAVojD9JOYh5/L0in85g1Add7Gz3ZQLcHC4AuhmI0?=
 =?us-ascii?q?KBbHrpgNcBHmcHsw4lQezlj12CVjFTZ3KsUK4m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BCC1CMF2rodoqdV/cXdi2dPtJhkiYFVbi9S44tzBSutAjnxLp6Ku?=
 =?us-ascii?q?rb5DYVtYzs1Ndr/e3fjxIy+iJuD8SbzW6NS3t4nmQSRz85xKp/u1Byyk+f0a?=
 =?us-ascii?q?hkhPxVDdhT5/JPUgcnOp/Q1u96BM7oWgLHYNiJTE2rQsupAT4vVNI92dwObF?=
 =?us-ascii?q?hnG9WkkB/D2zCmA7gPl7yEV9QI9ff+1n38PI5YzGzc1bJp21sjRdFVNHaOgK?=
 =?us-ascii?q?d6+gmVAJTGxRa3jaGvIJ8A0TbN+WHL9m+HuEVVQUYkSqnedWwObUvR69Li7w?=
 =?us-ascii?q?XNSKH4WudvCRdI1cPXcvgCUdbul1gTAa6+adk=3D?=
X-IPAS-Result: =?us-ascii?q?A2BjAAD5qeVc/wHyM5BdCB4BBgcGgVIICwGBZiqBbYQ7k?=
 =?us-ascii?q?1QBAQEBAQEGgTWJTo8JgXsJAQEBAQEBAQEBNAECAQGEQAKCMSM1CA4BAwEBA?=
 =?us-ascii?q?QQBAQEBAwEBbCiCOikBgmcBBSMVQRALDgoCAiYCAlcGDQgBAYJfP4F3FKgjg?=
 =?us-ascii?q?S+FR4MqgUaBDCiKM4EeF3iBB4E4ghsbNT6EH4MvglgEixQgiBeUZgmCD4IRk?=
 =?us-ascii?q?G8GG4IelBSOBJYnAjSBVysIAhgIIQ87gm2QbCMDgTYBAY1oAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 May 2019 20:03:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4MK3PHw010031;
        Wed, 22 May 2019 16:03:26 -0400
Subject: Re: [RFC] Turn lockdown into an LSM
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190521224013.3782-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1905221203070.3967@namei.org>
 <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
 <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
 <14ed1f30-a1d0-f973-5c8c-241337c8fc09@tycho.nsa.gov>
 <alpine.LRH.2.21.1905230457000.18826@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <39f774b7-c694-5c27-e428-2885a764bcbb@tycho.nsa.gov>
Date:   Wed, 22 May 2019 16:03:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1905230457000.18826@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 3:19 PM, James Morris wrote:
> On Wed, 22 May 2019, Stephen Smalley wrote:
> 
>> That seems to violate the intent of lockdown as I understood it, and
>> turns security_is_locked_down() into a finer-grained capable() call.
>> Also, if I understand correctly, this could only be done if one were to
>> disable the lockdown module in the lsm list, since the security
>> framework will return non-zero (i.e. the operation is locked down) if
>> any module that implements the hook returns non-zero; LSM is
>> "restrictive". At that point SELinux or the other LSM would be the sole
>> arbiter of lockdown decisions. SELinux or the other LSM also wouldn't
>> have access to the kernel_locked_down level unless that was exported in
>> some manner from the lockdown module.  Not sure how to compose these.
> 
> Right, I was envisaging the LSM replacing the default.
> 
> i.e. the default is tristate OR fine grained LSM policy.
> 
> They could in theory be composed restrictively, but this is likely not
> useful given the coarse grained default policy.  All the LSM could do is
> either further restrict none or integrity.
> 
> We'd need to figure out how to avoid confusing users in the case where
> multiple LSMs are registered for the hooks, possibly by having the
> lockdown LSM gate this and update the securityfs lockdown node with
> something like "lsm:smack".

Some kind of transition from the lockdown module to other security 
modules might be needed, e.g. you might need to start with 
lockdown=integrity to protect the kernel up to the point where a policy 
is loaded, then hand off to SELinux or another security module to handle 
further requests.


