Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7864EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D043206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfDYNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:36:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35736 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfDYNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:36:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so11213969pfh.2;
        Thu, 25 Apr 2019 06:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l17uPVGpdSiv8IfUe123oAga8SuqeCZI9ns3aS/aHQA=;
        b=ryb0Q2U9tiVUN1bI5XWSJ90q5fQ4ie8ePv9WxyV5xOVSDETrnAg2Rk8VdyPjObzv1Q
         xv1G4/mElBy2e/39+3BFLP0k6dMBantUKchoErrXZhyfGRKPUmQRaxYHdP5zHvc7I7Ic
         NJ+El10aMxrwrnA4mPsCspUec6UbBEFcr3MdjmRGQQryrKUhwUt7ygzy/5MNnMS8rSb9
         9Awig+pVqoA5rzZIDSyQj3ldD0OEZjgGINCaBEFq+BZCOmi9Y/z/OJx8PmfCtTx8paLu
         yq6rmjn2j73p0JEyk6t08xSyX/BaKfwNcm6wVllOqQtmmde9aOhFofKX8BR0j3Z1SLWc
         nTDA==
X-Gm-Message-State: APjAAAVyj9dg2hhhckXJ0wG4reUdIRjivtYLwee51X0luoHt0iEHl7a0
        tqc6KrIjMxw4dIEbhctE66sNLQtPZ1E=
X-Google-Smtp-Source: APXvYqwHF3LQd/hbE3iZGRyRB+bjoYMXBy+7bjmZVXvZiX7ckqln8SC8m5F8s/LsOHji83tNZFdrIg==
X-Received: by 2002:a63:2ad3:: with SMTP id q202mr19144778pgq.423.1556199360860;
        Thu, 25 Apr 2019 06:36:00 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id r145sm48531119pgr.84.2019.04.25.06.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:35:59 -0700 (PDT)
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems on
 Thinkpad X60
To:     Pavel Machek <pavel@denx.de>
Cc:     Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com,
        mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd> <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
 <20190424205150.GA4582@amd> <1556139361.161891.140.camel@acm.org>
 <20190425073343.GA19600@amd>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
Date:   Thu, 25 Apr 2019 06:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425073343.GA19600@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 12:33 AM, Pavel Machek wrote:
> On Wed 2019-04-24 13:56:01, Bart Van Assche wrote:
>> On Wed, 2019-04-24 at 22:51 +0200, Pavel Machek wrote:
>>> Unfortunately, that one does not revert cleanly on top of -next.
>>
>> Can you try the following:
>>
>> git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 &&
>>   git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
>>
>> I will see whether I can come up with a better way to analyze what is
>> going on. I had not expected that these patches would cause any suspend/
>> resume problems.
> 
> Not even d16ece reverts:
> 
> pavel@duo:/data/l/linux-next-32$ git show  | head -3
> commit 76c938fcaa4b4a5d8f05fa907925d5043834964e
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Tue Apr 23 20:24:59 2019 +1000
> pavel@duo:/data/l/linux-next-32$ git revert
> d16ece577bf2cee7f94bab75a0d967bcb89dd2a7
> error: could not revert d16ece5... scsi: sd: Inline sd_probe_part2()
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'

There has been a non-trivial merge between the block and scsi trees in
linux-next. That's probably what prevents these patches to revert
cleanly. How about performing the following tests:
* Build, boot and test Martin's latest for-5.2 branch
(git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git; branch
5.2/scsi-queue).
* If suspend/resume does not work reliably with that branch, revert the
two patches above, rebuild, reboot and retest.

Thanks,

Bart.
