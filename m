Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C11C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795752085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561013963;
	bh=TwxH0cGpgaOfrXZvnLnau5sYIWQMZi3Qzb1omLFQG3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xWjqhaHJ6hJhdT4HjExZFB2z8g+JZUM8MqIFBGcOxyg3OYf0LS12j5dY+1VOp4MX/
	 poDeHLo3N/VQssCtpLy1jkk10RzIG2PcoQR4uFd43MLii5HfcyCTO2S3Uc/6skRmOJ
	 JZVSjQlLXbnpdtU2wla2Hd2O+4dRN4lqJvMhHpCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfFTG7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:59:21 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39808 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:59:21 -0400
Received: by mail-wr1-f51.google.com with SMTP id x4so1773045wrt.6;
        Wed, 19 Jun 2019 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OwGe+wwXcxGE7MVG6NszekKRb+yyjl24bcgMiAUtrm8=;
        b=HnEPuIdWJ+u83Cf9tIV1Y5IC6qJoodMpYRNSSX717SVsMuubEVaFOF15XpaGGNUUvm
         OvqIOOPiTbJTCt4wBLL4u/G+/GgnVgluque9YCIA2zxTkOPLqK3iY0l0GUSkhs5waUL8
         m12HxFX7N3/M7/J4qgJEvbQsxvolsnRx7winfhTvAd+xuSO7LoBiIyuY+Yd8Uk9oRVZW
         IT/Rir6F14n25ZOFmBSBfSKCPmhLSLn0SoA3jqpmvEX+is+1FL9SQ9liqB27l7n0vLGk
         V1LjtbnQ8tIt+hutj4egRblsxDkeG4bSEJ2O3a0vXS1u9iV8JsKAlwNCCHl502MpGfa5
         tgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwGe+wwXcxGE7MVG6NszekKRb+yyjl24bcgMiAUtrm8=;
        b=dqgkwEisobwBpaOmodoGy2iAnkDRqlkaBi1IhwkXetHN3XuEbggpONlI/3gEeJxEMi
         mM1a1idJzRYWUNpJo0iko7v7o2gyo4AvNjulvbaB427XZqI9XU3T/uyvtkw/lDg8iOi/
         /WM6LzVdf5OT2li/IlBLw8oZ/hXmaZkYdvtzUMKieVXTiGdn1Vh9azj2sHb+6GY0L5iH
         YeulMwujAOD8Sc38+2iW+ZE4WCNakELzWp1J3bZud9E2vDw8106Q8cEopgJI4/8EiCQo
         FRVXSPX3DzZXT3nchKfIwLz78+QugEL9Xl7dsHmJ1IFrbry1x2K3vwVJDA0XTx41FW4O
         X61w==
X-Gm-Message-State: APjAAAWGNlArgbAtmvI4J+HPgKwXnMCaYpdxi/7O+0UrOodDtnWZJJdz
        0NRO0hS8Ui/0wbFI0LOvqWk=
X-Google-Smtp-Source: APXvYqx4wUtee1331pXODV1GHjEgfQo1oaXBp2gOzH07ls2ipj8cp/TLSt4r6m19NMIJUBBa68s3uQ==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr33312516wrs.1.1561013959169;
        Wed, 19 Jun 2019 23:59:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y12sm20860874wrr.3.2019.06.19.23.59.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 23:59:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:59:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        benbjiang@tencent.com, zhenzhong.duan@oracle.com,
        neeraju@codeaurora.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, oleg@redhat.com
Subject: Re: [GIT PULL rcu/next] RCU commits for 5.3
Message-ID: <20190620065916.GA110390@gmail.com>
References: <20190618180742.GA8043@linux.ibm.com>
 <20190619125038.GA8922@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619125038.GA8922@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> On Tue, Jun 18, 2019 at 11:07:42AM -0700, Paul E. McKenney wrote:
> > Hello, Ingo,
> > 
> > This pull request contains the following changes:
> 
> Gah!!!  This one has some duplicated commits, so please ignore.
> I will send an updated pull request early next week.
> 
> It is functionally correct, but...
> 
> One of those weeks, I guess.  :-/

No problem! :-)

Thanks,

	Ingo
