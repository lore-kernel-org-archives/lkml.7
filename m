Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B16AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55773217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yd9ED5Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCLXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:11:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfCLXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:11:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CMxUGw025289;
        Tue, 12 Mar 2019 23:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QgBCqq5O+vEk+EovhRZ4bNYaRj3SLnZ6LwcqFgpHFoY=;
 b=Yd9ED5HvEZhNTJixatM3Gt97DoIo4xVIcolIdswY+cmTmVnoA4I7GxGSsbylcOc7prxm
 U0mlJ0ztRVKpswC3FTpjsa7QBA1wfc/JkBw9hVGpzIxkIMXTle5Gsf2urDKYiQXz7sKK
 LJUMqV8+ktDuERd4FJgom/ea+9Rowq70du6PtTn1y+d7RSVaRbytdIi6VUJ/33SEbzFU
 j40lifubaczC27OjH/OnSpoXtDQ+4F0OYVfQebI6tAdG6QBoZbygz8Qk2LKoWLhx99BQ
 PzQCcmuWJOkPNWoL8UelwzoQbLo+lPI3nhVui9GhrsqZECdWsI1yA2xTfcWyE2AL3peY Pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r464rfq30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 23:09:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2CN9Ine019764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 23:09:18 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2CN9HWn019575;
        Tue, 12 Mar 2019 23:09:17 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 16:09:17 -0700
Subject: Re: [Qemu-devel] ssh session with qemu-arm using busybox
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernelnewbies@kernelnewbies.org, qemu-devel@nongnu.org,
        open list <linux-kernel@vger.kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
 <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
 <CAOuPNLg4dfoovZ_eqL5XvNW3Ak9dGeCVr=vbG6G5t4Rxo-nC9Q@mail.gmail.com>
 <00078ed3-fe1d-722e-0943-80bb189ee3ab@arm.com>
 <CAOuPNLhvPypbTU+AbodYTFdGHW_Uqxj4UQvo6usNCKZh30uTig@mail.gmail.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <dde54d03-0231-6d3e-46ff-519df15fe077@oracle.com>
Date:   Wed, 13 Mar 2019 07:12:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOuPNLhvPypbTU+AbodYTFdGHW_Uqxj4UQvo6usNCKZh30uTig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/19 1:08 AM, Pintu Agarwal wrote:
> On Tue, Mar 12, 2019 at 7:41 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 12/03/2019 14:02, Pintu Agarwal wrote:
>>>>
>>>> -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>>>> -net user \
>>>>
>>>> and you 'll get guest's port 22 to be forwarded to hosts port 2222, so
>>>> you can do
>>>>
>>>> ssh root@localhost:2222
>>>>
>>>> from the host.
>>>>
>>>
>>> I tried many different options, but unfortunately none worked for me.
>>> 1)
>>> qemu-system-arm -M vexpress-a9 -m 1024M -kernel
>>> ../KERNEL/linux/arch/arm/boot/zImage -dtb
>>> ../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
>>> rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
>>> ip=dhcp" -nographic -smp 4 -netdev user,id=unet,hostfwd=tcp::2222-:22
>>> -net user
>>>
>>> With this the eth0 interface is removed, and I see this message
>>> (although login works):
>>> qemu-system-arm: warning: hub 0 with no nics
>>> qemu-system-arm: warning: netdev unet has no peer
>>> Booting Linux on physical CPU 0x0
>>> <skip>
>>> NET: Registered protocol family 17
>>> <skip>
>>> Run /sbin/init as init process
>>> ifconfig: SIOCSIFADDR: No such device
>>> route: SIOCADDRT: Network is unreachable
>>>
>>> But, ssh is still not working.
>>> ssh root@localhost:2222
>>> ssh: Could not resolve hostname localhost:2222: Name or service not known
>>
>> man ssh
>>
>> +
>>
>> Make sure you have sshd in your custom rootfs and has been stared.
>>
> 
> My busybox is a very minimal rootfs. It hardly contains any commands.
> Is there any precompiled busybox for arm (cpio image), available (with
> ssh, scp and networking in-built), which I can use directly to boot ?
> 
> what else I am missing to make ssh/scp working on qemu ?
> 

When I was working on arm binary rewriting/instrumentation in the university, I
use the image created by Linaro.

http://releases.linaro.org/

One example would be

https://www.linaro.org/blog/linaro-16-04-release-available-for-download-2/

or

https://releases.linaro.org/archive/ubuntu/images/developer-arm64/15.12/linaro-vivid-developer-20151215-114.tar.gz

The license should be good for academia. I do not know if there is any
restrictions on commercial/industry usage.

Thank for Linaro again for providing those images which helped me a lot when I
was in the university!

Dongli Zhang

