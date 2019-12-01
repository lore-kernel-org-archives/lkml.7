Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75CAC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9316E2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575230148;
	bh=gcAay/Td/B8wDGu9UHnS72u/oJ0XHm0hBR7m7b2pQ9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=muz/BVuIKjy8Sa3VN8t0hoYggLEL4P+rAVSWyDNhZkgq4WrHkgLu+0RL5H64Rz9+g
	 1yTxaz/mnx/A43mF7aIIQGc5ViYwxIay/Qy7a4tNLlIU/D69ZNspZhjk4X3tfeOZux
	 fZbSfzFIwgwLVMvrMhG3RQFEI7Gfx0rFYp/ab0B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLATz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 14:55:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLATzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 14:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so41516499wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dLwpOWTcWF86S2Iv3wfh3f6rj4Jop1Meml+bicoVLKI=;
        b=Z2o1AhTkvHoJ1xg2unAn1vojTbwX2Obcu2UFlTokjoIN3jUDK/3qnU18GIvBHVWLND
         b1R2I5RfD9hc4+aJ7KHghJuU2pohspZ+HQcggFAcKS+9dTOBljEXsjoripq1WjRs+74M
         AzIIe+9BHATkFJT3BNihC7kg8E2z+zijbsKB19dVsw8UwxweunvhOY3LPVGSRTInE82V
         Y9ppJhD3yRjEQ8cvPw5YSGyTTSDnVWyqaBLrvMsDSLfA23jTJ4U/DIv8QzDdqOPXzI5t
         8JkeTfeLqKjRVMeJZGAZT8y3kA7jayaT/jUSDGMpFdzIjpPiGyZBvitoWMTLBn/ukFKH
         SUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dLwpOWTcWF86S2Iv3wfh3f6rj4Jop1Meml+bicoVLKI=;
        b=SQgzuTFGTQCefBakm6jwOTz7gfWRttBwOMQdx7k11GlaaLujO+jAOCPxd+30DlHQoR
         mvQXwZo9wV6Yub/vvLiCC1SeX1elu/pMcSnzTsKARLgEPmr6b0T0netFaZfKJkoG4kYl
         sdAHEw66gHt1oq//DWWI7DOSwKJ0oywd/lKDk5lVLgMBhGvNI6AWFUMGhYktxIzSeAmV
         PRDzFbJ5pyl1+lWNWyuXmQ0QTRy8eV6DBmP+T/iAFyO4brz5hbEzsMUEESiVJ8e1PP52
         2jg5joOYTSoFpSPA1scwcAXpwdxX2jb6GP43Y5SJWb4igZiQ5rmPU8nbbtEcDa+dgj1r
         Y52w==
X-Gm-Message-State: APjAAAWNzIEOulCcjnFLEdxa4N7BfVjfAguOP5oQAlN702m4sEIOqUoO
        JkW1T+YffRZx1PalhORrzFA=
X-Google-Smtp-Source: APXvYqwvQKTGhjwupIqogynM0sbD+miEneTaijeEf3zjyjIg8hgckOUvY6ZHR8nH4mNvuiC20xX5Sg==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr64183092wrv.187.1575230123657;
        Sun, 01 Dec 2019 11:55:23 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f67sm21519948wme.16.2019.12.01.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 11:55:23 -0800 (PST)
Date:   Sun, 1 Dec 2019 20:55:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
Message-ID: <20191201195521.GC3615@gmail.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com>
 <20191201144947.GA4167@gmail.com>
 <alpine.DEB.2.21.1912010906030.2748@hp-x360n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912010906030.2748@hp-x360n>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kenneth R. Crudup <kenny@panix.com> wrote:

> 
> On Sun, 1 Dec 2019, Ingo Molnar wrote:
> 
> > So it would be nice if everyone who is seeing this bug could test the
> > patch below against Linus's latest tree - does it fix the regression?
> 
> The patch fixes the issue for me.

Great, thanks!

> > If not then please send the before/after dump of
> > /sys/kernel/debug/x86/pat_memtype_list - and even if it works please send
> > the dumps so we can double check it all.
> 
> I don't have the "before patch" (but could if it is absolutely needed) but
> here's the "after patch":

> uncached-minus @ 0xfed91000-0xfed92000
> uncached-minus @ 0xff340000-0xff341000
> write-combining @ 0x4000000000-0x4010000000
> uncached-minus @ 0x4010000000-0x4010001000

I believe this is the region that caused the problem, the 0x4010000000 
'end' address of the WC region is the same as the 0x4010000000 'start' 
address of the UC- region that follows it.

> write-combining @ 0x604a800000-0x604b000000
> uncached-minus @ 0x604b100000-0x604b110000

This WC region was probably unaffected by the bug.

Thanks,

	Ingo
