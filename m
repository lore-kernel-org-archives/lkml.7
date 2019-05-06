Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEA0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F951206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qgj2/hg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEFVLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:11:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:54405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfEFVL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557177062;
        bh=/9l/qd+r58ylmiHOE4NA8AoDRrxfM+PNzgRWOgpNaPk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qgj2/hg5GuY0VuntTXIzZ8A6r4kqeWkPC2BWV4cOZpLZLAFKe+XPPyF+dAi3X/VTP
         izJB3T4xkESlCp30nQP3KxK77Ua1k58mmi7LIx+ovlUqr+LkUUoN21rTqbz2pkAPb9
         OcYp/h+vxhc1EbupTIhLulXc6tvSTKMTsWljSK4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.60] ([84.118.159.3]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbuo0-1gyHxK0jjA-00jL4A; Mon, 06
 May 2019 23:11:02 +0200
Subject: Re: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
To:     Karsten Merker <merker@debian.org>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
References: <20190506181134.9575-1-atish.patra@wdc.com>
 <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
 <20190506203956.ty6gkmhm4dlylld4@excalibur.cnev.de>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <d1c63af6-e1e0-4ec3-e97a-4c3e9ec11623@gmx.de>
Date:   Mon, 6 May 2019 23:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506203956.ty6gkmhm4dlylld4@excalibur.cnev.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6IwZrncBXf7Fh6U1XxTRe95WTouGkx4f8d1YiwRa/To0Rwtf/E
 fGVleujpBTNCRGQht31GNgCeFG7qROKK1mBAH7RR+WPDP42iycW9mr9R7aaftoH4ByQvI/3
 lvno0lbyMBY0SzkVGhp1yvIbkzXn3tY3FSUDqtyt41Zx5ONDhsaxgx8f6HdlsaUqLC6ZYIQ
 +p5rAFu59tEHvD7ejXQlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CS5Fp8jeRLc=:sIvm7dGh7Ctu0Rpx0Mj/ui
 ZxMMD0VeU6vKYUecnj7+ISeypUZmw2708mUQUzRK0kw7ofXCTCKxvb1VzmvTzwnVmNqYck5L8
 9swIbLF8VO8WlE2IG6aVCo+mlmUUyPdMtWItreqi8Yu9CKNyZsTNBlZTSKJMUX12v+qc7wThD
 b40EoBQsei0rd4OU0D8ATgBNSfZqjh4++J5cXIaZo6OB+7VwOZeCwDPVYkDYBu0LwW7auilPT
 IM1kHe1ODXAxzwDiwA85RMkGiO7eH4lSNacA6yic/7/0DbTMrYL8Osqs4e0y5LqctAQfFCrJL
 j/Y0TB8lopUtH1ACSb2k+UYFonGZChZnSQouxowapLrDLNiEnMWgDhdbRpTOmbWJI4Io8QPoG
 pOFZfsQv0eagKBhuDkicnxbCYDerJfk3bsiNfcgMVRT5HdKsRttA5uuVGVFscQlPAiSuOphgt
 UcitjgxvmHJ0BSkhJBY6CHEQ6tQlj3Ne7SnLaJmy7rtvC1XctG848p1IjBlyDtVQrVjjKxve3
 5C3Lj/aKnTCdxc/k8OWfc67OhpMWyV7w6JgC5S6VPohf46bHk48exe1nYbsnbOrub8lifTErA
 j0IuZOY2+dN+uzWQ26Cp1u6/yUzs4QZjvSeclgaKQvJVjrWskvVQWYAO6qsZ6az8r0nL0R0np
 dFsvZkV3snEKGEenV09jyRk6y72bhbUAOJD1G43ybhF5eLRXtDidq7RLegCKh4pbPxfWzHTs8
 6EZJ0qN+5s60MRhI+KBasw6810PJxFl9+qB8GggnCRyCe1XyBhN1EJt+kb36ifVYJlOgS5ZRY
 TsPc8kEzxX34q9GzxV91r2LXVgKYmByp7DbYRWEegFgDJ0pTzavmPByfi2LkKEqhY0R8PkAU/
 FN8r0aLxUZ89kqvx3IpCTLCqP4q3wTBCJ7nVIJOpIdaeYUENIKqTWQ84RhE535SxHv8njVBVa
 U8d3ls0giXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 10:39 PM, Karsten Merker wrote:
> On Mon, May 06, 2019 at 10:06:39PM +0200, Heinrich Schuchardt wrote:
>> On 5/6/19 8:11 PM, Atish Patra wrote:
>>> This patch adds booti support for RISC-V Linux kernel. The existing
>>> bootm method will also continue to work as it is.
> [...]
>>> +	"boot arm64/riscv Linux Image image from memory", booti_help_text
>>
>> %s/Image image/image/
>>
>> "arm64/riscv" is distracting. If I am on RISC-V I cannot boot an ARM64
>> image here. Remove the reference to the architecture, please.
>
> Hello,
>
> I'm not sure about the last point - ISTR (please correct me if my
> memory betrays me here) that an arm64 U-Boot can in principle be
> used to boot either an arm64 or an armv7 kernel, but the commands
> are different in those cases (booti for an arm64 "Image" format
> kernel and bootz for an armv7 "zImage" format kernel), so having
> the information which kernel format is supported by the
> respective commands appears useful to me.  If the arm64 kernel
> image format would have a distinctive name (like "zImage" on
> armv7 or "bzImage" on x86) that would be less problematic, but
> with the confusion potential of "boot a Linux Image" (as in the
> arm64/riscv-specific "Image" format) vs "boot a Linux image" (as
> in generally some form of kernel image), I think explicitly
> mentioning the supported architectures makes sense.

In this case you have to ensure that only the *supported* architectures
are mentioned. RISC-V is not supported on ARM64.

Best regards

Heinrich
