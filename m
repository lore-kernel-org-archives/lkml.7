Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71299C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23A218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNCeHKQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGDHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:30:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38128 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGDHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:30:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so4232893oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/l9q091iJ9jlOZDMSINHC8sirnGZUuXqQZD2C5fUG8=;
        b=jNCeHKQ5QfPSn8cioOrEquvk/atWL2iS4Brlk7s200bvEOKpmDUseZ7T7v5hFQg0qY
         EBOvTKCaCjfLVJk9NUpHU+Wifonr2t4GJoXT/dLUJwaEYOv378ImKqKzOvx7SWfMf8+w
         H03hpogOmAIob3qSK1ag8f0DucXB93M4b2QaAyOZ6h9EXSsJfGof5W2XbuAbwaAFCS6k
         MebUXyXGADPR2gWwjBioOX5Ntb9XepjETMWa8IKank+uIqmfPdr8JXDMYp7AS9wYN5F/
         lBl2WgXz72csjJUD/FWBukYXZ6b5S3kMwbDPyXUKJB95LWSZWEqs66sef6Sn0TvLvr1e
         ejPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/l9q091iJ9jlOZDMSINHC8sirnGZUuXqQZD2C5fUG8=;
        b=acxLWtiRJwXBlhzhefomgnkcC8fwzRrqPPNPyX/JeUrXy4b8vzCEsQSG+ENkGq0xua
         7dnEQ328SKhLfq4lBP+l3vheLad9brs18rH7y5DaRh5tKDKjPeap5wqqF2lFd/RXpt1x
         nYpRNaq3GinF8N++GWFrClK2nzQU2NROt54BDq2uh53NxRPXoUPIzcPxp2FyyTZT2hjd
         CehCLjF2myYyCLF57ag5AlzVmpg5+P6XIAS2wvdIYefnXa/KamXD5CMqVWawWobOnSmY
         lh1fJhx5hMe2N/PWL4Tkea1j7FKt4/PDCEkp/yClg5wvJOqqac/1QYB1CbTLHbVndce3
         M2pQ==
X-Gm-Message-State: APjAAAXr0n7/8IMT9qHXItLpohUO9FE6kbtr2BdbSU9GeN2XNet8Xuzi
        2+Juezkn0ffNTldZgYj3qakuxg==
X-Google-Smtp-Source: APXvYqwKhxZwXdpK9O0CdmMHegBrL9ntWx2osl6yxpMC9R8tjXNTIrsha36S7OWESW4jMfrxWYLLgw==
X-Received: by 2002:aca:4255:: with SMTP id p82mr1142651oia.6.1562225414842;
        Thu, 04 Jul 2019 00:30:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id k3sm1640278otr.1.2019.07.04.00.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 00:30:14 -0700 (PDT)
Date:   Thu, 4 Jul 2019 15:29:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 00/11] perf: Fix errors detected by Smatch
Message-ID: <20190704072958.GA26160@leoy-ThinkPad-X240s>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702110743.GA12694@krava>
 <20190703014808.GC6852@leoy-ThinkPad-X240s>
 <20190703181815.GB10740@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703181815.GB10740@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Jul 03, 2019 at 03:18:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 03, 2019 at 09:48:08AM +0800, Leo Yan escreveu:
> > On Tue, Jul 02, 2019 at 01:07:43PM +0200, Jiri Olsa wrote:
> > > On Tue, Jul 02, 2019 at 06:34:09PM +0800, Leo Yan wrote:
> > > > When I used static checker Smatch for perf building, the main target is
> > > > to check if there have any potential issues in Arm cs-etm code.  So
> > > > finally I get many reporting for errors/warnings.
> > > > 
> > > > I used below command for using static checker with perf building:
> > > > 
> > > >   # make VF=1 CORESIGHT=1 -C tools/perf/ \
> > > >     CHECK="/root/Work/smatch/smatch --full-path" \
> > > >     CC=/root/Work/smatch/cgcc | tee smatch_reports.txt
> > > > 
> > > > I reviewed the errors one by one, if I understood some of these errors
> > > > so changed the code as I can, this patch set is the working result; but
> > > > still leave some errors due to I don't know what's the best way to fix
> > > > it.  There also have many inconsistent indenting warnings.  So I firstly
> > > > send out this patch set and let's see what's the feedback from public
> > > > reviewing.
> > > > 
> > > > Leo Yan (11):
> > > >   perf report: Smatch: Fix potential NULL pointer dereference
> > > >   perf stat: Smatch: Fix use-after-freed pointer
> > > >   perf top: Smatch: Fix potential NULL pointer dereference
> > > >   perf annotate: Smatch: Fix dereferencing freed memory
> > > >   perf trace: Smatch: Fix potential NULL pointer dereference
> > > >   perf hists: Smatch: Fix potential NULL pointer dereference
> > > >   perf map: Smatch: Fix potential NULL pointer dereference
> > > >   perf session: Smatch: Fix potential NULL pointer dereference
> > > >   perf intel-bts: Smatch: Fix potential NULL pointer dereference
> > > >   perf intel-pt: Smatch: Fix potential NULL pointer dereference
> > > >   perf cs-etm: Smatch: Fix potential NULL pointer dereference
> > > 
> > > from quick look it all looks good to me, nice tool ;-)
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Thanks for reviewing, Jiri.
> > 
> > @Arnaldo, Just want to check, will you firstly pick up 01~05, 07,
> > 08/11 patches if you think they are okay?  Or you want to wait me to
> > spin new patch set with all patches after I gather all comments?
> 
> I'm picking up the uncontrovertial, will push to my perf/core branch,
> continue from there, please.

Will do it.  Thank you much for amendment in these patches.

Leo.
