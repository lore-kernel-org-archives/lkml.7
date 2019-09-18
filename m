Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93825218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Oq+fRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfIRXF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 19:05:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39461 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbfIRXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:05:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so1844331qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q82T9liBfZ7rrUs7RR2C4uQJYsl7Nk3PukCK0luYt8o=;
        b=M2Oq+fRYSnwHcUU3A0N1iML4ojDBJ14rCugal5twZg6FQdfbPaGsZShpRi0fwvXUML
         Kxm1g73P86HLLO681W+k9x05zf/0dNM/TnKvvJser01BTAFvL/b2paDME8+lD1X9IcqW
         Y6QbgeG8Xw8x5ptx9lMad21Ni2rgyEtlCwS2lM2JxUEMQtZqxDff0C/a6u5p8a6Fcr3E
         3FER1fWNYVWbJKO0SART48iORXD02JvOnX/isdtzVgAFWnC2Y9/et72U3U8HBu/leU7G
         3VVgsdnT3PdRqwHhXXZ/bIgnAsRvIoSaKrWV1tjFHQhEBPQZyHSSW6Ei7f8u8Cyh7UsP
         z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q82T9liBfZ7rrUs7RR2C4uQJYsl7Nk3PukCK0luYt8o=;
        b=qJjktHzMUjCXTCZ6SWjr3EFCPCf4IVpIsjANfrSGN6BLzoV7uXQ5DnVm86F6bnQpPg
         kbuOpqI2dvtXg9ybaLsTNNPpipc1PYsFYddOpLbDoWQBRm7UCH2kdtDgeFYTfppnI4FT
         idXF3N3wFgMI9meXDa96PbUY8hMMSGLdoSZVrxkxF2zSL3Hl1oAiZMvoMlD1Ckjl25tn
         GI0WM3IbFeoxbJxst8a8Jhfp0pVXE6/3Z2YId+QADf6RMtmuFlc1UMS9QlW/a/Fav6de
         uejahcV5e+qkYe4buL3qbvgSYuADpiELBzDpZKegtQoAlCjAuyGmK+P9C4IL0bMSW8AR
         cDjA==
X-Gm-Message-State: APjAAAUVQ+moITsDnUzkepg5vYkIy739CIOussXSDU3d243TXbxcp8Zf
        0QmbLyfq8pajmUfzOfruVSk=
X-Google-Smtp-Source: APXvYqzcPo7AFCXooamvaBW4+7CkEieTTgOIkkyvfXCXAykVFT7ENjyIuLkHVglVpC2xC9i6bHnzyg==
X-Received: by 2002:ac8:48cb:: with SMTP id l11mr262594qtr.292.1568847956468;
        Wed, 18 Sep 2019 16:05:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g194sm3626351qke.46.2019.09.18.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 16:05:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF2FC40340; Wed, 18 Sep 2019 20:05:51 -0300 (-03)
Date:   Wed, 18 Sep 2019 20:05:51 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naveen N Rao <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Perf/stat: Solve problems with repeat and interval
Message-ID: <20190918230551.GC32051@kernel.org>
References: <20190904094738.9558-1-srikar@linux.vnet.ibm.com>
 <fd84b64b-1288-ceab-2fa4-d090191ee0f6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd84b64b-1288-ceab-2fa4-d090191ee0f6@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 11, 2019 at 09:44:20AM +0530, Ravi Bangoria escreveu:
> 
> 
> On 9/4/19 3:17 PM, Srikar Dronamraju wrote:
> > There are some problems in perf stat when using a combination of repeat and
> > interval options. This series tries to fix them.
> 
> For the series:
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

I figured out where was that these features were broken so as to add
Fixes tags for both patches, please consider doing that next time, this
is important for getting this to be noticed by stable@kernel.org, added
CC to them as well.

- Arnaldo
