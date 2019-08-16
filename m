Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB3C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86E206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXLa4UKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHPPav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:30:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37414 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfHPPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:30:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so5090770qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jt02UbOvGrhZaofMxH9wPP7KStrcZG2dLeyzS5pAnLI=;
        b=aXLa4UKam/d2waXXIpI2GzPz9L1OfVpBz1ouTwujGgYQWs6ZyQIm0V9thkbbwYs+Xm
         mlWaU+RjY3sl+9jSukXT8Ff5Az0wmZ/U2dia6KYRIlBig9m5vPvml6PvZeXrB1e8pQV2
         w23rlHaP7oG05ULPLJj3uaWA8xfkTi8dN4fjIfPbITvZfsNfrj8dRQGd+IA2g7vNxpiw
         xL7ceN/ZQyoamwfmtbCXwPwOR+ObpBIGJg+qJrmJP2nltYqi33LLMiOIAWiWUa+s73QI
         6iIgjeLESSlsEkdjzvI2H3LVJe+sTQ4UGUzR9DBTNrqlnp7WY8abLCbZMG+SSaV6o+uc
         m7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jt02UbOvGrhZaofMxH9wPP7KStrcZG2dLeyzS5pAnLI=;
        b=ThxwYG22fh879n4xC7lB6/IZXMwjcJVxJmyKN0rmYHuMP7k7k1DmhWW6NOxMiJpN0q
         46odO6aIGHU7LS8rV6F+PACDREWeOcjzQpCXN4H2Wat/iFCl/PKmspiir4DnzEOcY35Q
         GshznIVgsQFFlhajztUNkH5idK4WVsM08oaF6Y5CYnVYR2t7JFABGdie6jtbrRTpfg36
         TCoj09sanLaN3BGGAqGHIoohfVjY0xxHhdd31lFJklLqfzvZoK3UpuSi5IxeTFlkHUNX
         WTLKW+vG0oRgZNsl3b1StfQrAimoz/H0cglNdlkGkMg/W98Mnaqdr4SMXLZfs38nx3VQ
         dhIw==
X-Gm-Message-State: APjAAAWD/3t40nYkp+bqS9wddmAFHUvXWbiTJtJLX2xSFInh+Hr6eZOi
        m8T9BbvkG1XD+QxMpQ9qtuo=
X-Google-Smtp-Source: APXvYqxDfTDNC0/CyAV7iTVhwMxF7BVFZXxKbHT7y3EBRmaZECkm0VQiTjYgqaEll4myeVTUUtdBHw==
X-Received: by 2002:a37:7844:: with SMTP id t65mr9545273qkc.166.1565969449746;
        Fri, 16 Aug 2019 08:30:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l123sm3127489qkc.9.2019.08.16.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:30:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91A5B40340; Fri, 16 Aug 2019 12:30:46 -0300 (-03)
Date:   Fri, 16 Aug 2019 12:30:46 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Keeping <john@metanate.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf unwind: fix libunwind when tid != pid
Message-ID: <20190816153046.GA22547@kernel.org>
References: <20190804124434.204da4ac.john@metanate.com>
 <20190815100146.28842-1-john@metanate.com>
 <20190815100146.28842-2-john@metanate.com>
 <20190815141035.GJ30356@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815141035.GJ30356@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 15, 2019 at 04:10:35PM +0200, Jiri Olsa escreveu:
> On Thu, Aug 15, 2019 at 11:01:45AM +0100, John Keeping wrote:
> > Commit e5adfc3e7e77 ("perf map: Synthesize maps only for thread group
> > leader") changed the recording side so that we no longer get mmap events
> > for threads other than the thread group leader (when synthesising these
> > events for threads which exist before perf is started).
> > 
> > When a file recorded after this change is loaded, the lack of mmap
> > records mean that unwinding is not set up for any other threads.
> > 
> > This can be seen in a simple record/report scenario:
> > 
> > 	perf record --call-graph=dwarf -t $TID
> > 	perf report
> > 
> > If $TID is a process ID then the report will show call graphs, but if
> > $TID is a secondary thread the output is as if --call-graph=none was
> > specified.
> 
> great, mucch clearler now
> 
> > 
> > Following the rationale in that commit, move the libunwind fields into
> > struct map_groups and update the libunwind functions to take this
> > instead of the struct thread.  This is only required for
> > unwind__finish_access which must now be called from map_groups__delete
> > and the others are changed for symmetry.
> > 
> > Note that unwind__get_entries keeps the thread argument since it is
> > required for symbol lookup and the libdw unwind provider uses the thread
> > ID.
> > 
> > Fixes: e5adfc3e7e77 ("perf map: Synthesize maps only for thread group leader")
> 
> for all 3 patches
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>


Thanks, applied.

- Arnaldo
