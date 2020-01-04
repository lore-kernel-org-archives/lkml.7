Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A28C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5B9217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVta00Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgADCoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:44:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44243 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgADCoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:44:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so24191088pgl.11;
        Fri, 03 Jan 2020 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GVVbPVx7gHQVvfWk7vlousq7bdc1Mt8QhmPFn2cIhCA=;
        b=fVta00HbjAJmANN0LLbWDiCHyXB0RqUCkXHrDQzrAmTQgKGtCil3QjvwdxUPOsjMkO
         ou5/FvLdO8T455OTqfch2wuzZIjJLx3uCzZbX+a8ZKLQ+6yNsH3i9CJIg5Uh1ZgGmzro
         G8k7cdmGN2ibOXv5dfdWPnnPRFDLhMSf3Rw3eaU0Z1seKcxwbqzTZjJk+AJF4ZIxWsTg
         M7UqWIVStnEdRzBXgiRR75el7IrZsGAub+XYOQWEFqmkqqTxIwZML8rVmr7ZOlgZKExr
         jvnOi/qeV7uidwvwiG1uW5m9Vjm16NbTJw7+v5cmwLq5KBkRoB6pvGht4n+/p8yh0843
         tm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVVbPVx7gHQVvfWk7vlousq7bdc1Mt8QhmPFn2cIhCA=;
        b=ofe5ig8jFHESYOqZkFKwhSdxpt2IOMGTUxA72KpXaGPnvTpWWGaLVAPzbiowRdS+Uu
         W46FvEFdi4soCfR96Bx4IEeMVgTe3YAXn23byigGXAPPKyyq0NSMtCgYo25OJ/zJFs+e
         NgSnMppzuLqDnLMJT1wLap6dmdagHqO8eTw8VBivri45hxSJWCKq2skM9BmLLbKKYSBV
         wLKrWOMGZVzXnQeAkLMBXpn2jScOizQliBYi8a8zK0gUbbWzKO4F9FYXKqnm+t7LxDcb
         buBMMwQ+RSbyFUQDDXPOzmR90L5W928P7SVs4zx6wZuM42dRK443x7YOUXWuzBR9AmjN
         0lJw==
X-Gm-Message-State: APjAAAUKu0CTvX5777N9Bg2wAVQdunt/f1o59Q1Nydyl730z68px1TL0
        lZalLglDncN5fGBWaLwOY1E=
X-Google-Smtp-Source: APXvYqxeivdPiC69dgxbXpNJQ5sWx9Tjf+1Jer7Cr8JLVfGV33oWOBDDuKJ1jUBt+bdLuGcRpM459Q==
X-Received: by 2002:a63:1666:: with SMTP id 38mr102632884pgw.325.1578105864751;
        Fri, 03 Jan 2020 18:44:24 -0800 (PST)
Received: from localhost (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id x197sm71716924pfc.1.2020.01.03.18.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 18:44:23 -0800 (PST)
Date:   Fri, 3 Jan 2020 18:44:21 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        David Miller <davem@davemloft.net>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] Improvements to the DSA deferred xmit
Message-ID: <20200104024421.GB1445@localhost>
References: <20191227014208.7189-1-olteanv@gmail.com>
 <20200102.134952.739616655559887645.davem@davemloft.net>
 <CA+h21horyGwqBTyBSVDRSSOSAPr_3i1dvz40=qKQMD_Nddtk3Q@mail.gmail.com>
 <4866462c-9e2b-ed7c-03a9-a2e81decf0c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4866462c-9e2b-ed7c-03a9-a2e81decf0c7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 12:10:44PM -0800, Florian Fainelli wrote:
> I sincerely think your transmit path is so radically different that your
> sja1105 driver should simply be absorbing all of this logic and the core
> DSA framework should be free of any deferred transmit logic. Can you
> consider doing that before the merge window ends?

+1

Thanks,
Richard
