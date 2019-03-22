Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC78EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3A1218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enaEQ19J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfCVQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:53:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37144 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCVQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:53:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so2639636ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XyBDQoTOXxQCDWDmwY1KbYgiZRQtfW/ijDyUEUHzSXI=;
        b=enaEQ19JDicle811gc6J7mwQDxxg8Y306l2M6YcqzVAbrMzYtAVurFVL8ELx+Sxj5n
         w7OVkW/3HicXdvIj26acGF+mXKbUfc5l7JViKwayxVdNYUaW165C725wW45pv6Ijycms
         9pF22OOkuKVMzzbMKWyOMS7ZUmFr+3SUx5Rgh2/DTGQg1vSj1GuNPpIxiTenorA01Z4N
         QT8KgklKhRm852MXGGaQNHVClAkVU4UJTFArG5n7JpxZpZ5hwtRP5o5SDwTJ1RXW26sW
         uQEIwNHOjnM1RqlH1BUCJh0S7qJNAz01e6V5eC+ECZt1HOt2DySyN74EafKnJ4HIesyA
         XzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XyBDQoTOXxQCDWDmwY1KbYgiZRQtfW/ijDyUEUHzSXI=;
        b=fl6Nx2CDyxAXLL8trMRKFrFIHX+YiNjJkDPRrj9Vqx0pdx21Lbox2Zai3CvR8dqwiD
         qGIJAN8m3gDcMMixcNTGHJJfSLnOmlg+Rqvr70t8vqai9vQKJJntQiBck2QVHS4StRbC
         9F5mHTNIqHHV3UFNu/SNeSEIqKbM8jhJ34PqAGV3TD3FGclLdKTzkM3Hv4fWbTTbL1oa
         +WgyGe9DRvxIfc6inJtp+AK20/QymWvDxJJIBgU6jx8Wx+P+YEd1mDFxNJbRT2P/e8uY
         X5xmetviwyiRoiC39oMYegor2HEtotG3eQ8oREifX00qq/p+V8hANhN2Q2R8BurqhPgT
         yzyg==
X-Gm-Message-State: APjAAAUiPLEJjEZVmYRqZXZaTJgwCPHuHdJuoIijigbBGLwE0dzb3VaA
        tNCZRVDXIL/aZhwHF/DEMhw=
X-Google-Smtp-Source: APXvYqysNmCALAhVcOSs1kkuBcI+Qk7HWnokHui3AM/LVQfdXORK6PFlkIEYPoPUiLC7w7yEQHlcwg==
X-Received: by 2002:a2e:4715:: with SMTP id u21mr5779442lja.156.1553273589662;
        Fri, 22 Mar 2019 09:53:09 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id m10sm1356704lfp.10.2019.03.22.09.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 09:53:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 22 Mar 2019 17:52:59 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-ID: <20190322165259.uorw6ymewjybxwwx@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:01:06PM -0700, Andrew Morton wrote:
> On Thu, 21 Mar 2019 20:03:26 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > Hello.
> > 
> > This is the v2 of the https://lkml.org/lkml/2018/10/19/786 rework. Instead of
> > referring you to that link, i will go through it again describing the improved
> > allocation method and provide changes between v1 and v2 in the end.
> > 
> > ...
> >
> 
> > Performance analysis
> > --------------------
> 
> Impressive numbers.  But this is presumably a worst-case microbenchmark.
> 
> Are you able to describe the benefits which are observed in some
> real-world workload which someone cares about?
> 
We work with Android. Google uses its own tool called UiBench to measure
performance of UI. It counts dropped or delayed frames, or as they call it,
jank. Basically if we deliver 59(should be 60) frames per second then we
get 1 junk/drop.

I see that on our devices avg-jank is lower. In our case Android graphics
pipeline uses vmalloc allocations which can lead to delays of UI content
to GPU. But such behavior depends on your platform, parts of the system
which make use of it and if they are critical to time or not.

Second example is indirect impact. During analysis of audio glitches
in high-resolution audio the source of drops were long alloc_vmap_area()
allocations.

# Explanation is here
ftp://vps418301.ovh.net/incoming/analysis_audio_glitches.txt

# Audio 10 seconds sample is here.
# The drop occurs at 00:09.295 you can hear it
ftp://vps418301.ovh.net/incoming/tst_440_HZ_tmp_1.wav

>
> It's a lot of new code. I t looks decent and I'll toss it in there for
> further testing.  Hopefully someone will be able to find the time for a
> detailed review.
> 
Thank you :)

> Trivial point: the code uses "inline" a lot.  Nowadays gcc cheerfully
> ignores that and does its own thing.  You might want to look at the
> effects of simply deleting all that.  Is the generated code better or
> worse or the same?  If something really needs to be inlined then use
> __always_inline, preferably with a comment explaining why it is there.
> 
When the main core functionalities are "inlined" i see the benefit. 
At least, it is noticeable by the "test driver". But i agree that
i should check one more time to see what can be excluded and used
as a regular call. Thanks for the hint, it is worth to go with
__always_inline instead.

--
Vlad Rezki
