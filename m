Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B7ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485B206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jemE8ipv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJGVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:07:38 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:32430 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfJGVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570482457; x=1602018457;
  h=mime-version:from:date:message-id:subject:to;
  bh=bY+sRheD73coXZxadpgSFqLWLuQ/U6qbrle3fNbHs8Y=;
  b=jemE8ipvkJhph+bX1Rw6A7qoXohqUIIYVHxHsEWT0OWrnnwZhoIBOwMw
   F455PDyfjckxKf7GNdSuBUbchiwh5iKb5NE21PtMih6E/9AhEE7iHkU//
   FvPGJ11Y7ZkjDEit2VrTd7T2j7IR2D9S5vP07xFXmXFjH/+e9S+elFSmS
   gOYcoAq5VsMZ/SsCJfqSGE9+bGiLcoGl9Hq45f+iPshl/Y1g7y0GdLMhC
   5Mtv8eHHG37mdtxwgAht1+0w8Upp2X263vbTrSfxhBYTRMbGzhjouE+I/
   8WBkXz/luqsE2M1KnwIrraX7Z5k4z8z1F7fTMtQTDGsQBrEfvRI7vcI5d
   Q==;
IronPort-SDR: 7/752GCyEhXfAlYiEQZNd+CnoMJGq+a1LVLutnCNv3a6PtmJLmE73If/VfraebiTnYpXsJ6GGf
 SCRxEBZMM+O3QVY6tRk7OfrdRR2SfVybP/bG8CsH+Wddot0Z3cInwOQ1MZdX8y459ka7mvjaAq
 DGL8w4Wk2+A8GWZ6KtLx31FXXaNySiX9zJeBqkPUu0Bpl7wIl/N0PYfFykI+Q6Pmx0FuA4jfKQ
 D7Pb8owlnYkLKYRLBy2XmpqfFvwqQKQMUsuKNNnWuxoEYkrkvgvs21SvOsdw0+I3kRZb7MOT03
 1gk=
IronPort-PHdr: =?us-ascii?q?9a23=3AnQ23OhwRbdRxu13XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uwfIJqq85mqBkHD//Il1AaPAdyAra8bwLOK6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7N/IRe5oQnMucQanJZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dKQ8RfWDFbAo6kYIQBD+QPM+VFoYfju1QDtge+CRW2Ce/z1jNEmn370Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoMv3TVrdT1NLoSUeeox6bLzTXMdfJW0ir65YnIcxEhoeuDXb?=
 =?us-ascii?q?NsfcbNx0QiDB7FgUmKqYD/ITyay/kNvnGd4uF9Vuyvk3Yqpx9trjWr3MshiY?=
 =?us-ascii?q?nEipgLxlzY9ih12ps5KNm6RUN9fNWqCoFftzuAOItzWs4iRmZotzskxbAeop?=
 =?us-ascii?q?67eTQKyIwgxx7Cd/yLa4iI7QznVOaWOTp4gWhqeLO7hxqr9UigyPDwWtC60F?=
 =?us-ascii?q?pXqidIkMPAtn8K1xzU5ciHTuVy8l291jaI0gDf8uBEIUYqmqrHM5Mt3KI8m5?=
 =?us-ascii?q?4JvUnAHiL6glv6gLOVe0k+5+Sl7+bqbq3jppCGNo90jg/+Mr4pmsy6Gek5Mg?=
 =?us-ascii?q?kPX2iB9uS9yLHv4UP0Ta5XjvIqiKnVqo7VKtkGpqKhGQ9azp4j6wqjDzehyN?=
 =?us-ascii?q?kYmXgHLFRYeBOIloTpOE/BIOr+Dfihh1Shiylrx//YMb37GJnNLWbMkK3nfb?=
 =?us-ascii?q?lj705Q0g0zzcpQ58EcNrZUAvv2U0u5lNXUD1cCOgi1xq6zCtVm/oYZW2uTC7?=
 =?us-ascii?q?OEdqjVtAnMrskoJebEW4YTt36pO/k04OOoknY/llQae6aB0p4eaXT+FfNjdQ?=
 =?us-ascii?q?HRQ3v2g585EH0JuUJqTu3wiXWYXCVVenK2XuQh/Wd/QISrEYvOWKizj7Gbmi?=
 =?us-ascii?q?S2BJtbYiZBEF/IWXPpcZiUHvQBciSfJud/nTEeE7usUYks0VeprgC+g4hnL/?=
 =?us-ascii?q?vJ/GUhtJvlnIxn5+zCiBcr3TdvSdmWySeAQ3wi2isjRzIw07Fi6Xd6zFjLha?=
 =?us-ascii?q?NjhPpXPddIoe5CSEE3OYOKnMJgDNWnawPTfsqOAGSmS9TuVSAjTtswm4dVS1?=
 =?us-ascii?q?t2AZOvgg2VjHniOKMci7HeXM98yanbxXWkYp8lk3s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HFAgB4qJtdh8XQVdFmDoIQhBCETY5?=
 =?us-ascii?q?hhRcBhneFWYEYijQBCAEBAQ4vAQGHHyM3Bg4CAwkBAQUBAQEBAQUEAQECEAE?=
 =?us-ascii?q?BAQgNCQgphUCCOikBg1URfA8CJgIkEgEFASIBNIMAggsFokSBAzyLJoEyhAw?=
 =?us-ascii?q?BhFUBCQ2BSBJ6KIwOgheBEYNQh1GCWASBOAEBAZUsllQBBgKCEBSMVIhEG4I?=
 =?us-ascii?q?qAZcUjiyZSw8jgUWBfDMaJX8GZ4FPTxAUgWmNcQQBViSSHAEB?=
X-IPAS-Result: =?us-ascii?q?A2HFAgB4qJtdh8XQVdFmDoIQhBCETY5hhRcBhneFWYEYi?=
 =?us-ascii?q?jQBCAEBAQ4vAQGHHyM3Bg4CAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgphUCCO?=
 =?us-ascii?q?ikBg1URfA8CJgIkEgEFASIBNIMAggsFokSBAzyLJoEyhAwBhFUBCQ2BSBJ6K?=
 =?us-ascii?q?IwOgheBEYNQh1GCWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiyZSw8jg?=
 =?us-ascii?q?UWBfDMaJX8GZ4FPTxAUgWmNcQQBViSSHAEB?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="80780759"
Received: from mail-lj1-f197.google.com ([209.85.208.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 14:07:36 -0700
Received: by mail-lj1-f197.google.com with SMTP id v24so3869041ljh.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QpIogHTFQ3PNntbyxY8PuVYh6DjinLK9PCtFfqPpljY=;
        b=BuQuy0YfDDftNYdABX/8V647XecEe+FtNwxyXLsDVWxCKBeeehYMsfBBjSlEIftXLK
         PCeJ4PeP/Xzhgk03C2aweFZLufCAFR4qQJ4MgwmSmc4Mom8IDUQqRSk0gQyFA4+7Q0mz
         hpms1xjFJMNxqQ5uQ5HE1Prx3vjuy0d71AkkQiB38SIRrXReV3c2uvHDSSFJOmgczEx5
         swHQB4fgfiBLoX2ulDu5dmiVMSxRSgdJnyx3MMqxpHvHd6OQD5VENi9nhc64PyO14/iz
         tpl+cIwxeLRdcE6Vr0HQ8RxS3Xcnjsb5vQ8Eq9iPpTmGILAHuupecXfHKdmcU46nfxcM
         zYvg==
X-Gm-Message-State: APjAAAVQhFWKdOmjGmGx6OnfoqtqrkWh7llUUcjTVwldEawyS5N2Le6w
        twe6CBncFfIBi4f+kyo1sPR5IkTZ+7PsJ2HHWkIFUX8XE0BO/Kqb/Cv6vLJbRd9AN4QHoIKHJj7
        /550svz/jjQKnJnacQPUtPJcCsmJmhV/AIPkRY3aP1A==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19683308ljk.92.1570482451459;
        Mon, 07 Oct 2019 14:07:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsaH0jQUXUcxBHYc6wDRLiz7uWnqfB2f4Igx5phAG/R7tvZNQRLqqwJ8r8TZxhh4PC22EU4Ifczy46vVpcjnc=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19683288ljk.92.1570482451154;
 Mon, 07 Oct 2019 14:07:31 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 14:08:14 -0700
Message-ID: <CABvMjLRuGnatUxBEMKpXWGNJnAjNMiCXQ7Ce88ejuuJJnENR+g@mail.gmail.com>
Subject: Potential NULL pointer deference in net: sched
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

net/sched/sch_mq.c:
Inside function mq_dump_class(), mq_queue_get() could return NULL,
however, the return value of dev_queue is not checked  and get used.
This could potentially be unsafe.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
