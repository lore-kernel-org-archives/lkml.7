Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB00EC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461420870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YQ0GY5em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfIEI3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:29:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:35529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732628AbfIEI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567672125;
        bh=t7W1mOvSdT7FOnR+iJZMPkkVrv1ufI9+MEcjVA3FqQY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YQ0GY5emBWtF2+ARETctDQd8UbjUSt+7ponkJxaBHMFGgOFmEG1tE3om/960jzKUP
         rUVbLf3mOp3FxgVDPQQ1K75Tr/3QcB4Fm96IgsC/A63irqY0fiIHircyIRjyufjxzy
         A86Mpka/2UoIK052efvAbgW+4tqhORzkWRRgSIIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1iGk-1iPwPf0u7u-00toiu; Thu, 05
 Sep 2019 10:28:45 +0200
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <86r24vrwyh.wl-maz@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <754fb77a-aace-e0aa-a5bb-a6c6bcff9890@gmx.de>
Date:   Thu, 5 Sep 2019 10:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <86r24vrwyh.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eaUsm+16cI+R1zRcdIsQOLAO6sdEkj8i+rShDso7dOQJA3nRcY+
 VTOE55Nsdz4pR3H8aP0fFrW8lWq9Jbia0oD9USGdOLuY7ZlGNKikVKt+zXBjIAWn3SLx4hy
 fqoArj8gvqB8ws48EHaCKZweAnVS/X7+AiMTNMorZ8RK6WOuEjAxko686tWkag1OK2n7h0Y
 ZEfc9obZitTHgvedP3CZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l5eBDt4PzLo=:fMWCUZGhlpaBB4ITFb8nf8
 Sb/Bu/pfSLJSVhFXafFMMT65q8hZ45JMyWnskj9IypAOjK9ORc4Tm4sBI2mjTUAgXr+P0wOg8
 7D1yPWvCeJQjAF9Vqqpn1HnN0zNO40crkclaMZE11Hzj5n42De0kG6EanF5tFHHS3K2oXjtw9
 uh/TWTCR3JIZwr7LvTi2HeOe+4Dht62nDymF36IPeEp0uV8j5/CrbEJLHMIZEweOrO63w2Npt
 haXP9cUBt3oSin8yaW4TOT7OfE/z2QMRiy09dJbrU0lIZs414Xwmm7eGgLYWQhWZRE3nyUkoJ
 t3gJ29jlpJSyl/QfKLWErzzFhZ/XVBPIOf5cdk/UKo6keHqtLBuFA6KcAqO/zHgO6t1a7LkZG
 /P3qYcb+B2uKAgEuFPqvWn9Adgcv/iOYfnQMV99HMz8h4GUzS+45huHWapscBsqJUt7lB9i/A
 7tQ6//jEr76NDWYtUgD/W+dPBHjByclRh3gWFE46kQrxzbZiGQhTWRdJHARLpqdmga+stYloP
 zzTtN6WE6KM/V33rnBcUsmEQrp2EHcLlrtcpFXaf2aqYmxQp7GP+0Zk2Yjq6zRFqjyevr/gLn
 +PUs1pCw5teJlOK+ZVC2IUemie8+giX0sIL0rvCDoxnZRYShAZqGx8Dfr9uU/mHmUjBT4sUUY
 goFBqpnizKRE4eZ2Bz0M7SQru79pO6myRuW8yX87CBvRqa6AppOWV1bwIwy6agxXoaCS301wj
 kjG0EhnWBgq2mlM4SHyecGhSW4cizvuRKrLBmAxmwu2f48b1l521S4IBImAlNeTsKZj+uXgpq
 C6NB126etAEGRdTCtFZXlsjBsnMAZtlFmIZJllnPZ0b5qJBVVQPPplTxsgP1+SbtUBG823m6h
 aTR98YQL+dJQcM2vwt/E7na0Rm0eyhs0SLMy0fOei8onZP500i57O3HvFTdMtAe9c7xBWCvR+
 +dW08tX+IkNUaTh3yyNHsosx2Vag4jU0XjHM+OKQz0QMWxF0HkkMa5S9n3skGIqKBet8UH86E
 +d/HXx/lZCxJj17mmBQiRsGSY4CSDChNyapVYPLE/v1degS9rsPxhBgOh2/Sq/yH8XbYe/ro+
 3Yhe7M1bYc1ZiiFXbM8z+tA8WDW3pe1RHqWHckUnfSckhS2Lzt2SzXFvtrVXmPHxEZfDgVNCt
 VfTX1cJ/HYExDBxKSTlbszXUwxQxmowXU9EWXCgeGfFAsaJ5eJK2oZ4dLmEOxoUlpSuT8IW2X
 d7AveIFrdMz3Tmy9R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 10:03 AM, Marc Zyngier wrote:
> [Please use my kernel.org address. My arm.com address will disappear sho=
rtly]
>
> On Wed, 04 Sep 2019 19:07:36 +0100,
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> If an application tries to access memory that is not mapped, an error
>> ENOSYS, "load/store instruction decoding not implemented" may occur.
>> QEMU will hang with a register dump.
>>
>> Instead create a data abort that can be handled gracefully by the
>> application running in the virtual environment.
>>
>> Now the virtual machine can react to the event in the most appropriate
>> way - by recovering, by writing an informative log, or by rebooting.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   virt/kvm/arm/mmio.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
>> index a8a6a0c883f1..0cbed7d6a0f4 100644
>> --- a/virt/kvm/arm/mmio.c
>> +++ b/virt/kvm/arm/mmio.c
>> @@ -161,8 +161,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_=
run *run,
>>   		if (ret)
>>   			return ret;
>>   	} else {
>> -		kvm_err("load/store instruction decoding not implemented\n");
>> -		return -ENOSYS;
>> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>> +		return 1;
>
> How can you tell that the access would fault? You have no idea at that
> stage (the kernel doesn't know about the MMIO ranges that userspace
> handles). All you know is that you're faced with a memory access that
> you cannot emulate in the kernel. Injecting a data abort at that stage
> is not something that the architecture allows.
>
> If you want to address this, consider forwarding the access to
> userspace. You'll only need an instruction decoder (supporting T1, T2,
> A32 and A64) and a S1 page table walker (one per page table format,
> all three of them) to emulate the access (having taken care of
> stopping all the other vcpus to make sure there is no concurrent
> modification of the page tables). You'll then be able to return the
> result of the access back to the kernel.

If I understand you right, the problem has to be fixed in QEMU and not
in KVM.

Is there an example of such a forwarding already available in QEMU?

>
> Of course, the best thing would be to actually fix the guest so that
> it doesn't use non-emulatable MMIO accesses. In general, that the sign
> of a bug in low-level accessors.

My problem was to find out where in my guest (U-Boot running UEFI SCT)
the problem occurred. With this patch U-Boot gave me the relative
address in Shell.efi and I was able to locate what was wrong in U-Boot's
UEFI implementation.

Thanks for reviewing.

Heinrich
