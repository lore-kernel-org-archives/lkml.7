Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B89207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBamrTQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCJO0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 10:26:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41024 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfCJO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 10:26:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2so2278944wrw.8;
        Sun, 10 Mar 2019 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bKrirO9pKvLzGsKPzgeRh/i0qug68+6lLxkCr9w5nk=;
        b=OBamrTQ7KXgaG2C/Q5Tl5pB+u3rB+1KD+KLKLs4ZoqFOxxO0ypG8oK+Wdc5tbIFIYO
         L0BAbctjxsWSYxoicfY5nJCLBqxGWuxDS/aU9ikdfsBAY/flZcHdP7PbcOsgTgT70Qk8
         vq4RBBfmf5IFy5Ywm7Dtlq+OfhTkAUnz11h2fwym3tv6Wq2R3kCFGLURNZstZAw0Jy4b
         9f2i/sxLZANlqOHH4U90JAAQF+h+RawGrXHXo6rFa5b8vq3TK3dzlpTRailgkeHo3sFc
         hX88M+K6y0bD3AWwdPGbzLupeZg8/85ChPVT1lrGaBSI9nkeEt3aq5oCLsKcWUBM6bP+
         7I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bKrirO9pKvLzGsKPzgeRh/i0qug68+6lLxkCr9w5nk=;
        b=VVYf5KGvMsfxOl2+3+l+yPUF9edqLd9eVmRr1nxPM6j3UYqKuSjAJtc353i8i/JwMb
         UIhajSrTinIOqfchZ9OWcIMFonnclXuwpRn3JhL0IeDmG3reyFUqxCIAZYEkQ/+Li8S4
         mdlDmXJ+ZDxZ4cKZnKH8/S3H82a4xBoBdHDblwi2aTnYnVNGxUmA/NBTm0ny7rjbDMPy
         hZD6bjc57YtGAaj4p1ZO0ysHJKV5AZ+ZYtgjreHnVH9A7rM8RPH3t0XqfJ/DjfWeXA19
         t/CB/z2FkyTyfu6xeeaZd0i7ioikV0f0jspHGejSUXg71JTY9HzRuQE9odd9PsqkHTim
         4jjw==
X-Gm-Message-State: APjAAAVulEgyPo+CZ2jAyQflMgKxXVXyj5qcGgMJhRTneXRWzTDbUzqw
        1hdCjOFudAA5q5mHXSRNYwymxmV1
X-Google-Smtp-Source: APXvYqxK2yGL/Bf0wjh+3dcvFWxy4PQyXEUuxc3xJ4Nk66T/+d2eANnAgHXUFCNWU1+dyudEYWuFIw==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr1174986wru.312.1552227980610;
        Sun, 10 Mar 2019 07:26:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bf1:e200:c0d3:171b:900:dd4e? (p200300EA8BF1E200C0D3171B0900DD4E.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:c0d3:171b:900:dd4e])
        by smtp.googlemail.com with ESMTPSA id v1sm3713977wrt.88.2019.03.10.07.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 07:26:20 -0700 (PDT)
Subject: Re: r8169 only works in promisc mode
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
 <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
 <20190310071853.3c726dbc@shemminger-XPS-13-9360>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2fbb9488-198f-0a9c-af3b-bb45bf424884@gmail.com>
Date:   Sun, 10 Mar 2019 15:26:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310071853.3c726dbc@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2019 15:18, Stephen Hemminger wrote:
> On Sat, 9 Mar 2019 10:33:40 +0100
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 09.03.2019 03:16, Alex Xu (Hello71) wrote:
>>> After suspending, my r8169 (not actually 8169, just that driver) only 
>>> receives packets when in promiscuous mode. I have tried disabling all 
>>> offload features except highdma [fixed], and it doesn't fix the issue.
>>>
>>> I am using torvalds/linux, compiled about two days ago (not sure which 
>>> commit). I think this happened after a recent upgrade (some time in the 
>>> past week). Given the long testing cycle, I don't really want to bisect; 
>>> I am hoping someone has some idea of where the issue could be.
>>>   
>> The provided information isn't enough to say anything. Please create a
>> bug ticket in bugzilla. Needed information:
>> - Last working and first failing kernel version (as reported by uname -a)
>> - Is 5.0 ok?
>> - Full dmesg log
>> - lspci -vv output for the network card
>> - If the issue happens only after resume from suspend, diff of the
>>   chip registers (ethtool -d) before and after suspend.
>> - Does removing / reloading the r8169 module fix the issue?
>>
>>> Please CC me on replies.
>>>
>>> Thanks,
>>> Alex.
>>>   
>> Heiner
> 
> Bugzilla is not really used by Linux network developers.
> I just filter/forward mail from bugzilla into netdev.
> 
To make sure I understand you correctly:
Are you just saying "network developers don't actively scan bugzilla"
or do you want to say that bugzilla shouldn't be used in general for
netdev bugs/issues? What would be the right tool then?
