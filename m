Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B8ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112482190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b4RMAMJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJJRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:48:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39981 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfJJRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:48:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so9920222qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYn1vCkpH2UTkYb1MjEld3EXDRqgDSQ+QW91PhLxXEg=;
        b=b4RMAMJqUWpE9nTsf3SUUcuR/dfk6xQY+sq5BMJ5OJYcAGbuJN/PV5K+RXiRRjiLV6
         wPzwh9Yy6224tWvt4cNkhUroXnczv6DSj/IiK+QpUuUdoBOiynjlptf89TdxqryA+j73
         IZlgMx/YKZXjVlLD+qAaNcspz80/XwLf55KxkSr/1kDEVVeSkVe6l4vjKuV40qZNjb7K
         BHQ6MnHZ0hSKfTTSJNO1oUIyPH179JC3zuDfcZAq3v1eYEoPQ/TxVF3x2QRWp/gl/YQh
         7YbSlKvmM8JWxyo4Gd0hYE49BlY06Y8f545WmQlOdphnF2Qqx+r4rWeQH9y5UWFnd/zH
         HqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYn1vCkpH2UTkYb1MjEld3EXDRqgDSQ+QW91PhLxXEg=;
        b=gzseq2gLow6RdDFefJQy5lUNZrjrXaH15akiVP/EW3RDmfDCWuhy50LOj/+F4/d2y/
         jke2FAeEgQFZosWN11mw4ZYqE7zDK6TohqHg3/2VDT5ou/RZ9ZdthOzReqSljOzQgHrO
         ghxMzD3j1DFvdXkEqGb2PXzNHmUXy48JyTatPckpSMVVk+4r1olXLoyH4HtyzUXN3+Yt
         QCvsC6v659G9gDpBf60uw+bH4UPP6WtZssnRzdjNJ/Go8vVtZve0kn0DOJoakTdxG9fJ
         4iif6k2xfbxPC7IDzs2ikTNVDJlXbwL3sLH5v5YWtBjFrDiFR4A6RV8T1gXd/s3yz0TW
         bHLQ==
X-Gm-Message-State: APjAAAWOD34139w3GpIeKp89voMlOnINGOIsrRvf3M+YCISktNA5U5Ig
        vk/PX4p0hE/X9DrGQUpsHncx0g==
X-Google-Smtp-Source: APXvYqy2QuWmiOejsKpqxjUS01WpAo08ztOf+vAMcZ2cohqpxD9OrkReBY+a++681Kf6Or7CgIKYqg==
X-Received: by 2002:ac8:2653:: with SMTP id v19mr12076131qtv.278.1570729688691;
        Thu, 10 Oct 2019 10:48:08 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm3048644qkc.123.2019.10.10.10.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:48:07 -0700 (PDT)
Message-ID: <1570729686.5937.30.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 13:48:06 -0400
In-Reply-To: <20191010173040.GK18412@dhcp22.suse.cz>
References: <20191009162339.GI6681@dhcp22.suse.cz>
         <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
         <20191010105927.GG18412@dhcp22.suse.cz> <1570713112.5937.26.camel@lca.pw>
         <20191010141820.GI18412@dhcp22.suse.cz> <1570718858.5937.28.camel@lca.pw>
         <20191010173040.GK18412@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 19:30 +0200, Michal Hocko wrote:
> On Thu 10-10-19 10:47:38, Qian Cai wrote:
> > On Thu, 2019-10-10 at 16:18 +0200, Michal Hocko wrote:
> > > On Thu 10-10-19 09:11:52, Qian Cai wrote:
> > > > On Thu, 2019-10-10 at 12:59 +0200, Michal Hocko wrote:
> > > > > On Thu 10-10-19 05:01:44, Qian Cai wrote:
> > > > > > 
> > > > > > 
> > > > > > > On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > > 
> > > > > > > If this was only about the memory offline code then I would agree. But
> > > > > > > we are talking about any printk from the zone->lock context and that is
> > > > > > > a bigger deal. Besides that it is quite natural that the printk code
> > > > > > > should be more universal and allow to be also called from the MM
> > > > > > > contexts as much as possible. If there is any really strong reason this
> > > > > > > is not possible then it should be documented at least.
> > > > > > 
> > > > > > Where is the best place to document this? I am thinking about under
> > > > > > the “struct zone” definition’s lock field in mmzone.h.
> > > > > 
> > > > > I am not sure TBH and I do not think we have reached the state where
> > > > > this would be the only way forward.
> > > > 
> > > > How about I revised the changelog to focus on memory offline rather than making
> > > > a rule that nobody should call printk() with zone->lock held?
> > > 
> > > If you are to remove the CONFIG_DEBUG_VM printk then I am all for it. I
> > > am still not convinced that fiddling with dump_page in the isolation
> > > code is justified though.
> > 
> > No, dump_page() there has to be fixed together for memory offline to be useful.
> > What's the other options it has here?
> 
> I would really prefer to not repeat myself
> http://lkml.kernel.org/r/20191010074049.GD18412@dhcp22.suse.cz

Care to elaborate what does that mean? I am confused on if you finally agree on
no printk() while held zone->lock or not. You said "If there is absolutely
no way around that then we might have to bite a bullet and consider some
of MM locks a land of no printk." which makes me think you agreed, but your
stance from the last reply seems you were opposite to it.

> 
> > By not holding zone->lock in dump_page()
> > from set_migratetype_isolate(), it even has a good side-effect to increase the
> > system throughput as dump_page() could be time-consuming. It may make the code a
> > bit cleaner by introducing a has_unmovable_pages_locked() version.
> 
> I do not see why we should really optimize this cold path.
