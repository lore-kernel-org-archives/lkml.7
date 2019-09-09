Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F5C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463B12171F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiJZrmOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfIIW2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:28:39 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:34638 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfIIW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:28:39 -0400
Received: by mail-pl1-f174.google.com with SMTP id d3so7387336plr.1;
        Mon, 09 Sep 2019 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAn8IpAmOtMXWCgfpoL9j9qAM0y4KxMC9732xfWmZJQ=;
        b=KiJZrmOI4YCI/s9j7mQHSQKC30BjtOtDW7qRnqwBEOeZa8XAMCX+Agp9cu36nays4r
         C7+oUv8SleVKlRoE1ywT1/+sw54xLsEJezeiAG5YZAw7/M1rjjPyGdz264A2sqgjtvWC
         O/qg5pXrPRtyhgwm2EBLgLpK3PbhzjyASKoeB/RCJgOdg2wgG56dREh1BzriQDtz44EJ
         a4xNgZVgsQ8Z4SnErRRFieLwubPv7jwnocI6TtNj2hGIY/mrJm7gDnp9FYPY7GN8NDtp
         gWN+foA2z8OwU2nIfae76C6DLCjcps4skJTiOBr+rtQnKx5LXiSzKeIJaIDmESJ6tda8
         /Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAn8IpAmOtMXWCgfpoL9j9qAM0y4KxMC9732xfWmZJQ=;
        b=uHJYg6dde90vigIIrx3gP7gDca4KG3+qMWla2xq2ZN28KpwSinnUEceUls9q/bbT3s
         Mu4HoaVvW5wl0xDehvGa2a0pvk6LHb/OFeIvoKH2XdDgwq5I0/3s2jv5blohl1l8Fjpy
         ZOxzzlEWOXWdl8xDCti+1ba/Hait3dzzBBMuy8tshhHaA9IpvOcJ0VeC+Spc+8rViHYW
         mm+yEf0otVDMxZ895ZZ8JguiQz3XfBhsQVjL4+apusWl/62wp/TKk2zF/zDsbrg+QsmF
         TGt8NuBkA6n4GFYWqyCKBatflj++sPTaVo2EKcc2Yoz3eT+SrqulJmdKLH0QVPKNntHQ
         fT2w==
X-Gm-Message-State: APjAAAWBCv9sjoxXE4DWNO0HHKMXrHwgkOmhemP8nsNIpnLcnVJQKKwQ
        +cCTcg4wQJZ7kDnSBFBGFTu+YKjkV6zFVwrDkhU=
X-Google-Smtp-Source: APXvYqwbIMZVq0K8Cuua0yz5yfyQva73B+aq0av7Hqo0Zuh95TRHipBELXiHZvIouJ8gHkq+C++I7Csv6fJda47pb6E=
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr27019001pld.61.1568068117004;
 Mon, 09 Sep 2019 15:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e3a76c0592047ea7@google.com>
In-Reply-To: <000000000000e3a76c0592047ea7@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 9 Sep 2019 15:28:25 -0700
Message-ID: <CAM_iQpU454RbtUAqPU1fL8MHRf9umDf6Hsn_6A0eak0Hr9x3xw@mail.gmail.com>
Subject: Re: WARNING in cbs_dequeue_soft
To:     syzbot <syzbot+cdbea9b616d35e2365ae@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Leandro Dorileo <leandro.maciel.dorileo@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vedang.patel@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: net/sched: cbs: Set default link speed to 10 Mbps in cbs_set_port_rate
