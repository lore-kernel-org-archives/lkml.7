Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17715C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC6D20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYmx5PV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCSB3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:29:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:29:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so12628624pgl.9;
        Mon, 18 Mar 2019 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hj6/XNA3cZRTtNm+qzA60GjinHeuxf4jZE292Kw1gY4=;
        b=OYmx5PV6qtsM8S44snMqF6rh8RAp1BQw2QDMLpVjCdrYKV+uSRNrIiKi457Cg3Thh/
         5DoQcAKWWuptK0/jDMyB/Lku7kw3jg2pMGI/uNAf8hEutYcFKoDh8oaiez7cx4Sk7G3c
         fn+q//fBrrPzIt3xn8Ha8rHVhi+6p/mXZBm3bANDdmQaqbP91v0gKf+7NxLzhQTjTYQU
         Lr5VHmKSOyy7potb0x5eMYq1/p4Iy779CPietyQ1nKvtUEEMB9IAEpeKxv/p45One9Ja
         EiXT2n/rMMWYt2GBOgHAw4oOFWONqnnGRq7TeNlLzFjnyvf8H0sg5PbxyRwL2YDidVPS
         40Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj6/XNA3cZRTtNm+qzA60GjinHeuxf4jZE292Kw1gY4=;
        b=BmUCi0UDtnKALrLTIDQbRxOlS0OYyrbG+zL0e2EQUuNRVSWJaExGuIv00va9BPTHT0
         PVbZJPYWcv36CJpz21UZiuf+NIUEQOgaLv8tlh0Id7quBmyGRodZZUCfcAqkUDKW1HN1
         IRsixwMMZxRSAvO1fIxYqErQq0xveYYzbXZBe5h78SHbe7LcOHuK0+X05w75jeg0Xkhf
         Bdik1Legfg+3nVRH013tWpWQ+t78JZUHfeik5lipQJa84DxaKk4sd3cTDMtT2x0U5JQW
         E8LRVn60J0GDp9jd69ZZcfC6AIkCGRrMZoVsfjGtBLEqsSDKxrWAN3uR6LHyZ+iBxkQc
         sogA==
X-Gm-Message-State: APjAAAUiYtEKT/TwJzv65iDBcPUUbV8p/PnQT4ou6sq3DT3xA4LRps/t
        U0BePOirCeAHcAnk8Wl8boRupEFl
X-Google-Smtp-Source: APXvYqxMltlcb683MrTHU/IU7MRMihLqwbCNenAePR/Q6pW4o4jdhlf6k8FMZTSw0zmdYhbbvCOgrA==
X-Received: by 2002:a17:902:b684:: with SMTP id c4mr23059656pls.294.1552958959389;
        Mon, 18 Mar 2019 18:29:19 -0700 (PDT)
Received: from localhost ([175.223.38.238])
        by smtp.gmail.com with ESMTPSA id m3sm12965517pgp.85.2019.03.18.18.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 18:29:18 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:29:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190319012914.GA9313@jagdpanzerIV>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
 <20190316051902.GA27630@tigerII.localdomain>
 <20190316142646.GA10815@tigerII.localdomain>
 <20190318163208.GC7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318163208.GC7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/18/19 09:32), Stanislav Fomichev wrote:
[..]
> > -#define bpf_htons(x)				\
> > -	(__builtin_constant_p(x) ?		\
> > -	 __bpf_constant_htons(x) : __bpf_htons(x))
> > -#define bpf_ntohs(x)				\
> > -	(__builtin_constant_p(x) ?		\
> > -	 __bpf_constant_ntohs(x) : __bpf_ntohs(x))
> > -#define bpf_htonl(x)				\
> > -	(__builtin_constant_p(x) ?		\
> > -	 __bpf_constant_htonl(x) : __bpf_htonl(x))
> > -#define bpf_ntohl(x)				\
> > -	(__builtin_constant_p(x) ?		\
> > -	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
> > +#define bpf_htons(x)	__bpf_htons((x))
> > +#define bpf_ntohs(x)	__bpf_ntohs((x))
> > +#define bpf_htonl(x)	__bpf_htonl((x))
> > +#define bpf_ntohl(x)	__bpf_ntohl((x))
> At this point we can probably drop __bpf_xxx as well?
> Care to resend with proper description when bpf-next opens?

OK.

	-ss
