Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3435CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBBB214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="NhVH8N4H";
	dkim=pass (2048-bit key) header.d=paloaltonetworks-com.20150623.gappssmtp.com header.i=@paloaltonetworks-com.20150623.gappssmtp.com header.b="WE241TQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfKDQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:15:35 -0500
Received: from mx0a-00169c01.pphosted.com ([67.231.148.124]:35848 "EHLO
        mx0b-00169c01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728144AbfKDQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:15:35 -0500
Received: from pps.filterd (m0045114.ppops.net [127.0.0.1])
        by mx0a-00169c01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4GF9HG026849
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 08:15:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paloaltonetworks.com;
 h=mime-version : references : in-reply-to : from : date : message-id :
 subject : to : cc : content-type; s=PPS12012017;
 bh=mFhURUNVmFWcOu3bxAoWR3XpZvxWQeC5PUvoch+yHXI=;
 b=NhVH8N4HCz+6c944X1nCX/mAdnqMzbRA3ar/y38JvFviGGIs7Oy7gXqMZ9KgMWi4wxek
 5AlhKGi/HiUfOm9c4ZbjA2JRjPCgG85LViN58zQ8p5Yrb6XyJ2DrcTf4PNLZlV9TVa1H
 R0PjUPU0/AAAJoAhLKaHFI2P446mKsjFue6cStnVDjYzOvXLeaqytCs/0qFnnathq4Yj
 oNJubA9sWVB+EMGgkji4mB8aH4vX1B3/LStXAMQsOAaQ11apm/t/+v1hRbNkiuBiy2Mk
 j5ickHwRDSF77WzVSAPyaZUY93v/QoC/fl748Oh+eC2OHx5LYWLeglTEUA+M+JzXBAvB SA== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0a-00169c01.pphosted.com with ESMTP id 2w15tpmfef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:15:32 -0800
Received: by mail-qk1-f197.google.com with SMTP id q125so443541qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paloaltonetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFhURUNVmFWcOu3bxAoWR3XpZvxWQeC5PUvoch+yHXI=;
        b=WE241TQU3pR7IXvEdzH/1ByttVaPiDTtg7NfhEZ28PqfYdPX/QPaOLrZFjHfRG4UEj
         2/VfW6zy0gF1CggKc+ma8L1uo3qcEHEWaoFHFMJUzbmRNVBCuG3Q97+WxDpHECwZeB1u
         /ZK0F1OPCoJDTcrmfhlev9frVrVY0Q6Ws/F3FaTSu7JIkT1pZXyj0g5UloTm5E802Wf1
         3KxpeI8HX/2GuOSO2cRidmEnMe8z57M0TvzryenY1C8hh7Tv21SMdulL+BPA5+0TTNkm
         QYwcaCAu22dFzlII8P5nH/yHTAg70uZrcO4nsRvUIVrTwRM/2yhq0FK0NQDLg1vpj8L0
         iRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFhURUNVmFWcOu3bxAoWR3XpZvxWQeC5PUvoch+yHXI=;
        b=LSHJLftgSQ0Ij4bUSVmbIXqoi5g15C15oujZLjUPKLe1ryXvFSLo2WSIu615/T+A2u
         ZNpNb+OUs6d4D8RbGcWv689lzzSQMcEiZFbBDKeTdemLfSRsMTfZTM8lZjmcV8SzuSwV
         g6NTN74XdrZ0xNW2U1+ebC5i1fsOhkUVwEx8LT1eTVEEYRAlR5cygw4MXvO96HdqMFKK
         HSmVka/WROfO7KrG+KAoGmsiEaffGu3cPBqChc0htyqNUHLXzraqZSr6SEz3WV3yKRu7
         JEX6QosrfiX0zyQGzOYxQ6IYqeyQERtFSokTJC9+myY2WV+B20JcxLpuPFOA2mkr5HuK
         ySQg==
X-Gm-Message-State: APjAAAVbk4umnj8+SatUqXrEztWNWSMZqOUxz05J2U0hCP0XIM/NQQOo
        79cxJMKaiU6lr9RHXKPZnRlnR+CHl+q6yTDwhjhKfcx2KGngBmNp/te2fEUD9OOrRASbow8OKQ3
        Y/g0BZhAykSQ4eElrwI5Ot8KvUoHiZGmywm28uErR
X-Received: by 2002:a37:a345:: with SMTP id m66mr8778508qke.487.1572884129531;
        Mon, 04 Nov 2019 08:15:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyuGILi78KyAardmQCKs5xKqadPINvUZ2fEIIDrZhELvvCV6dEx6RFACMSUCvq3Yz08Zb6CEoHkOO9XEVONs8=
X-Received: by 2002:a37:a345:: with SMTP id m66mr8778457qke.487.1572884129211;
 Mon, 04 Nov 2019 08:15:29 -0800 (PST)
MIME-Version: 1.0
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
 <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
From:   Or Cohen <orcohen@paloaltonetworks.com>
Date:   Mon, 4 Nov 2019 08:15:18 -0800
Message-ID: <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        textshell@uchuujin.de, Daniel Vetter <daniel.vetter@ffwll.ch>,
        sam@ravnborg.org, mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 suspectscore=1 mlxscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=803 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@gregkh@linuxfoundation.org @nico@fluxnic.net  - Thanks for the quick response.
@gregkh@linuxfoundation.org  - Regarding your question, I don't think
the 1 byte buffer is related to the problem. (  it's just was there in
the initial reproducer the fuzzer created, and I forgot to remove it
while reducing code from the reproducer ).
I think the problem is related to the huge size argument , which
influences  the initialization of "this_round".

On Mon, Nov 4, 2019 at 7:50 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Mon, 4 Nov 2019, Greg KH wrote:
>
> > On Mon, Nov 04, 2019 at 04:39:55AM -0800, Or Cohen wrote:
> > > Hi,
> > > I discovered a OOB access bug using Syzkaller and decided to report it,
> > > as I could not find a similar report in syzkaller mailing list,
> > > syzkaller-bugs mailing list
> [...]
> >
> > I am at another conference at the moment and can't look at this much
> > now, will try to later this week...
>
> I'll looking into it now.
>
>
> Nicolas
