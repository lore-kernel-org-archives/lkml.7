Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D641AC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555479393;
	bh=nW9+C9kF7oatNqrgkRmWroqdrEHbhT42B8iKBBtl0z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJVPCe8n37DwATtOOlcOK1HIRb1lZvtEA+Qx8aGKlovdvsjfpE6DBkGouh8MD7uBc
	 eHSvoN6wDMIprEWNQpsnnedmiGdo+UecCLWVY6wknL1uJrt/8Ck06GWituri6QlWx5
	 jcACOXDlbboX8hIOABpASNkptY1X2ExAYxNTOy5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfDQFgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:36:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:36:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so30102488wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXBDR7hUBuEDMZDkWPjX+E2sNNVB/9/GJEMgkNEoLeA=;
        b=qWuu3JuA9wyrpLoDufBlXBHdvk8Pe7ToiTc6kNvOEwN7m7bpHsWllTJB+I/9ZBPwEd
         tGBx8vq0aYqrAmCG3nZl1cNbgrAeBALHCjhwcezEmjqLoDCzoc7WCLWfDK7zZD/GB89n
         5Z5e9w/veYMDNe68svMZYzGoYYbpwqOFBTYXzyWZ0c2Iead6jmqR+XqzV4R1bmKAW81u
         Uw5fCn1CzmZWE6WZ0GHUw6eOk0xJSIr4iKCOacdYr96d1mlWh0lW04SwNKTwqYxoDMHQ
         PKvjAC4F6ILLXgj1h7eGRG+Sjj+RvqA8l1HJWSHb5wxfLOyBwCkaknCy+0kbTt4Pdjg7
         uKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXBDR7hUBuEDMZDkWPjX+E2sNNVB/9/GJEMgkNEoLeA=;
        b=LAN31yp3nYZLb5vd5/DLKRnqhN2vl5pQXZy4UWMjGPCQRb3US4bnJjPIhk8tBTbBOz
         47fFAuf2eAXP/hGsUM7oWA4ahwfnlsIBPuXgFVO9Ecb6qfdvRr73X5Q7NNT8ZQt7EweB
         m4wdfvCIgfIU6u52nepELfYSDLyRqMpqW3xBqZyx7iQcMevqT6casOVHcyZxY3FBWFlN
         UeSCRWhAhXe5x6cq6Z9gkfZhtYJRs7XmCwTUH2ItiaZmJu1fjRGxnq8Zq5AW39TuF7mN
         hiRyInmWDKGO1Bktc7oMRm3lb3LccxgjReHbvPM559x8ygQS3S6Ng3FdmaV+rwgCgEvQ
         ZHEg==
X-Gm-Message-State: APjAAAUQQ+RL1clsxO304gIsQ3FrFNFOnw+1pEQFcrrCRsip8pj3znlM
        JA21l0r36EbWQuYUXO2lfwM=
X-Google-Smtp-Source: APXvYqwAt1vX5GvQDzHvBi/RGLMoVQQFXeCoYiqXFur8rRqwuwC1FSVP9CTRrCy9W5UZG26Oy+mKGQ==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr21825391wrw.167.1555479390096;
        Tue, 16 Apr 2019 22:36:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x14sm1262890wmj.3.2019.04.16.22.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:36:29 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:36:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190417053626.GA47282@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> The test results below shows 3-5% improvement in performance when
> using the third solution compared to the default system today where
> scheduler is unware of cpu capacity limitations due to thermal events.

The numbers look very promising!

I've rearranged the results to make the performance properties of the 
various approaches and parameters easier to see:

                                         (seconds, lower is better)

			                 Hackbench   Aobench   Dhrystone
                                         =========   =======   =========
Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
Instantaneous thermal pressure               10.16    141.63        1.15
Thermal Pressure Averaging:
      - PELT fmwk                             9.88    134.48        1.19
      - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
      - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
      - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12


Firstly, a couple of questions about the numbers:

   1)

      Is the 1.012 result for "non-PELT 250 msecs Dhrystone" really 1.012?
      You reported it as:

             non-PELT Algo. Decay : 250 ms   1.012                   7.02%

      But the formatting is significant 3 digits versus only two for all 
      the other results.

   2)

      You reported the hackbench numbers with "10 runs" - did the other 
      benchmarks use 10 runs as well? Maybe you used fewer runs for the 
      longest benchmark, Aobench?

Secondly, it appears the non-PELT decaying average is the best approach, 
but the results are a bit coarse around the ~250 msecs peak. Maybe it 
would be good to measure it in 50 msecs steps between 50 msecs and 1000 
msecs - but only if it can be scripted sanely:

A possible approach would be to add a debug sysctl for the tuning period, 
and script all these benchmark runs and the printing of the results. You 
could add another (debug) sysctl to turn the 'instant' logic on, and to 
restore vanilla kernel behavior as well - this makes it all much easier 
to script and measure with a single kernel image, without having to 
reboot the kernel. The sysctl overhead will not be measurable for 
workloads like this.

Then you can use "perf stat --null --table" to measure runtime and stddev 
easily and with a single tool, for example:

  dagon:~> perf stat --null --sync --repeat 10 --table ./hackbench 20 >benchmark.out

  Performance counter stats for './hackbench 20' (10 runs):

           # Table of individual measurements:
           0.15246 (-0.03960) ######
           0.20832 (+0.01627) ##
           0.17895 (-0.01310) ##
           0.19791 (+0.00585) #
           0.19209 (+0.00004) #
           0.19406 (+0.00201) #
           0.22484 (+0.03278) ###
           0.18695 (-0.00511) #
           0.19032 (-0.00174) #
           0.19464 (+0.00259) #

           # Final result:
           0.19205 +- 0.00592 seconds time elapsed  ( +-  3.08% )

Note how all the individual measurements can be captured this way, 
without seeing the benchmark output itself. So difference benchmarks can 
be measured this way, assuming they don't have too long setup time.

Thanks,

	Ingo
