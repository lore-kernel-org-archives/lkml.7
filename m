Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7310C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43F2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbfDRLmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:42:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbfDRLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:42:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so2597589wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPNVvj2myBt2QeHAMt5EoRNrApWzBDH4PJTi3ss/nPA=;
        b=lC6Mkx7hgJli8Wmg+b4G02c+WA318DucznKA37vm5O7v6gSyFQy5OuSCYYPPtOQdXa
         xfUD39jHZQRQA9/wzvoY9nuB6oCzyiY0HRH6+ngHKRyrQq4Xgoes2Lx7eYE6Z/XXWCik
         ue00YfVbTZRQFIHUAMW1kzYquuUVdX/xagcbT177Vj5W8WNM4EfVcXkxfWKDeE1WY44j
         z2A7PP9GAvrNXAAO2pvQVEBjvOaQcmUh8hEVjmvRnVbPVxzlrZZoahLjbYCkvU12hzzJ
         GNu7NA7EBeaogaJf95SeflHcE7MlhAqKGEF6Fl7Ndyl9jCRasu93QE+fFWUemc0QdA6O
         8wIA==
X-Gm-Message-State: APjAAAUfgRkWTHEsZHj+0iRXHhZ1pnnjtk5GZPkE4FBM2Gpzc6mJjvOe
        KVIQhwqQQldvjJwWt9R0ceVKR9KSI8k=
X-Google-Smtp-Source: APXvYqy8Lo66Fou0Ee8rujqq8FgI1HCN8U0t8icBvhwcy4YUrdi4pho7M6s+6rglq26Edo97X8dURQ==
X-Received: by 2002:adf:db05:: with SMTP id s5mr63275734wri.247.1555587723693;
        Thu, 18 Apr 2019 04:42:03 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e12sm1481740wrt.94.2019.04.18.04.42.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:42:03 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
Date:   Thu, 18 Apr 2019 13:42:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert,

On 11-04-19 21:50, Robert R. Howell wrote:
> On 4/8/19 2:16 AM, Hans de Goede wrote:>
>>
>> Hmm, interesting so you have hibernation working on a T100TA
>> (with 5.0 + 02e45646d53b reverted), right ?
>>
> Hi Hans and Kai-Heng
> 
> First, apologies for how long it took me to reply to both your inquiries.
> In trying to answer them I discovered some inconsistencies in how the T100TA was
> behaving on different hibernation attempts and I've been trying to sort those out.
> I haven't been completely successful in that, but here's a brief summary.
> 
> Yes I do have hibernation working (at least most of the time) on a T100TA,
> with 5.0 + 02e45646d53b reverted (more about that below), and with a systemd
> hibernate script also described below.
> 
> Trying to be more quantitative about "most of the time" is in part want I've been
> testing the last few days.  I just finished a cycle of 20 hibernates/resumes
> which were all successful at least in the sense that after resume internal
> sound was working, along with all the other critical functions I care about
> (WiFi, Bluetooth, etc.).  However I have occasionally (perhaps 1 in 10 times)
> seen something go wrong with sound on resume and the only way to get it
> working again was to a full reboot.  During the successful cycles I also
> sometimes see i2c_designware or intel_sst_acpi error messages but they
> don't seem to indicate an unrecoverable failure.  I was hoping to sort out
> what errors I was seen on the occasions where sound was lost till a reboot,
> but those are rare enough I haven't been able to sort out the difference
> between those and the "recoverable" errors.
> 
> Regarding the revert of 02e45646d53b, there were some code changes in
> adjacent lines so a simple revert wouldn't apply cleanly to 5.0.0
> but the changes were small enough that I was able to manually "merge"
> the revert and the 5.0.0 changes.  I have posted a patch file under
> Bugzilla: <https://bugzilla.kernel.org/show_bug.cgi?id=202139>
> showing what I actually did to revert 02e45646d53b for 5.0.0.  As I mentioned
> in an earlier message, I have NOT been able to produce a working revert of
> 02e45646d53b for the 5.1-rc3 kernel.
> 
> To make hibernation work on the T100 I also had to create a script
> /usr/lib/systemd/system-sleep/t100_hibernate.sh which unloads various drivers
> (including sound) before hibernate, then restarts them afterwords.  I've inserted
> it below.  I'm not certain all the steps in it are still necessary, but the
> intermittent failures make it very difficult to determine what is absolutely essential.
> 
> -----t100_hibernate.sh  systemd script-------
> #!/bin/bash
> echo "Hibernate script $1 $2"
> [ $2 != 'hibernate' ] && exit 0
> 
> case $1 in
>          pre)
>      echo "Going to $2..."
>      /sbin/modprobe -r brcmfmac
>      /sbin/modprobe -r hci_uart
>      /sbin/modprobe -r battery
>      /sbin/modprobe -r hid_multitouch
>      /usr/bin/killall pulseaudio
>      /sbin/modprobe -r snd_soc_sst_bytcr_rt5640
>      /sbin/modprobe -r snd_soc_rt5640
>      /sbin/modprobe -r snd_soc_sst_acpi
>          ;;
>          post)
>      echo "Waking from $2..."
>      /sbin/modprobe brcmfmac
>      /sbin/modprobe hci_uart
>      /sbin/modprobe battery
>      /sbin/modprobe hid_multitouch
>      # Just load the following and it will pull in other snd modules
>      /sbin/modprobe snd_soc_sst_acpi
>      /usr/sbin/service NetworkManager restart
>      /usr/sbin/service wpa_supplicant restart
>      # The above is usually enough but occasionally sound doesn't come up properly
>      # and doing the following seems to restore it in those cases.
>      /usr/bin/killall pulseaudio
>      /usr/sbin/rmmod snd_soc_sst_bytcr_rt5640
>      /usr/sbin/rmmod snd_soc_rt5640
>      /usr/sbin modprobe snd_soc_rt5640
>      /usr/sbin modprobe snd_soc_sst_bytcr_rt5640
>          ;;
> esac
> -----end of script-------------------------------
> 
> I'll send a second message with the system logs which Kai-Heng requested,
> with his patch applied to 5.1-rc3.

Ok, so you have hibernation sort of working, with a bunch of hacks.

This is exactly why I usually do not spend any time on trying to get
hibernation to work.

Still since my patch is regressing things for you I will try to
take a look at this and see if I can reproduce and come up with
a fix. But this is not going to be a high priority thing for me to
work on.

In the mean time I've gone ahead and submitted my version of the
fix for the problem Kai-Heng was seeing, since that does not seem
to make your problem worse; and it will be good to get that problem
fixed.

Regards,

Hans

