Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A7DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C888E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4wAx+KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDPEhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:37:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35491 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfDPEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:37:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so9672307plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 21:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=E2J8FCcZICudBVADKm6eTLtEY6cfhmZTKVVTnYMjWvM=;
        b=h4wAx+KMXQyv56jGbe28LksTwtxU8ui9V0UUjEUdzC9Ng6Jb+8kDRiUtMiFCwLvYaA
         Xao6MoF86DoaPZTzsbIWDLSPn9pzf1bPFI4YLpZzPddMcR9dyEYZ7CM5P7VxtnDYW+OB
         dmfiALn9FRC1zA4dRZzdjxpeoTufjJSiZ6T/F4yDTXatnFXZwLbY7XkVxs0UNj7izMGJ
         holbFbJXIwgwsLfipnGUNrntDUbX6X3Tr0HMPRlGrcokvVqHD8rEZnwKewKFDjcU7tsu
         dPw4HkgbMHpy74VuiK8cdeb8korDrekLqXhkI9/NAUJHQ+vkkRyNhJzFjwmWCwympXgq
         lHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=E2J8FCcZICudBVADKm6eTLtEY6cfhmZTKVVTnYMjWvM=;
        b=P3IGO62bVCzr120ep4WzPul3h5YLra6HmVLCI2G+dvRfxRgTeBYiZAC5fQyajTdacE
         Wft+MBep5R10hpWc3XOXdw1V8oKg2XO2BIMPkVdT2MlOkwO9LEfp0ffGubljprThfibU
         Jm7VakvrBeebcuY6qV+B7qitPV1k5UswIn3q5JeAil3dFeNqXNUkBmbL8LPRXkSkmgZI
         V/WxXQNv5ue/jmfEpHwGo+lzTQponjn40jQNIdiACoqqUw55jrhRtCLTItqsGY6g7eTA
         oYk8ckHGTy0Wjbzz+2vGC0km01o+O6xP15u2bIcXcvUhl8pVdCzxCAS5u1ZVzr438/2v
         yyWA==
X-Gm-Message-State: APjAAAXTECz2gdBTBmVt6o6McTbyoyDglhR1RsKcXynUv1Qoz/GtOTnf
        C6biIR166Kg5mpZXm7kOxfI=
X-Google-Smtp-Source: APXvYqxob3352s++Kw4hIPaC4lgQEAN2KmtNSAnK1QkCcbZAWKkeOyPF99GItYbRTMw4loMTgeiogw==
X-Received: by 2002:a17:902:e084:: with SMTP id cb4mr81560747plb.77.1555389424887;
        Mon, 15 Apr 2019 21:37:04 -0700 (PDT)
Received: from localhost (61-68-62-84.tpgi.com.au. [61.68.62.84])
        by smtp.gmail.com with ESMTPSA id i24sm69181844pfo.85.2019.04.15.21.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 21:37:03 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:36:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
        <87bm1dfog4.fsf@morokweng.localdomain>
In-Reply-To: <87bm1dfog4.fsf@morokweng.localdomain>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555389147.okxbj1prw2.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann's on April 11, 2019 9:08 am:
>=20
> Hello,
>=20
> Ping?
>=20
> --=20
> Thiago Jung Bauermann
> IBM Linux Technology Center
>=20
>=20
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>=20
>> When testing DLPAR CPU add/remove on a system under stress,
>> pseries_cpu_die() doesn't wait long enough for a CPU to die:
>>
>> [  446.983944] cpu 148 (hwid 148) Ready to die...
>> [  446.984062] cpu 149 (hwid 149) Ready to die...
>> [  446.993518] cpu 150 (hwid 150) Ready to die...
>> [  446.993543] Querying DEAD? cpu 150 (150) shows 2
>> [  446.994098] cpu 151 (hwid 151) Ready to die...
>> [  447.133726] cpu 136 (hwid 136) Ready to die...
>> [  447.403532] cpu 137 (hwid 137) Ready to die...
>> [  447.403772] cpu 138 (hwid 138) Ready to die...
>> [  447.403839] cpu 139 (hwid 139) Ready to die...
>> [  447.403887] cpu 140 (hwid 140) Ready to die...
>> [  447.403937] cpu 141 (hwid 141) Ready to die...
>> [  447.403979] cpu 142 (hwid 142) Ready to die...
>> [  447.404038] cpu 143 (hwid 143) Ready to die...
>> [  447.513546] cpu 128 (hwid 128) Ready to die...
>> [  447.693533] cpu 129 (hwid 129) Ready to die...
>> [  447.693999] cpu 130 (hwid 130) Ready to die...
>> [  447.703530] cpu 131 (hwid 131) Ready to die...
>> [  447.704087] Querying DEAD? cpu 132 (132) shows 2
>> [  447.704102] cpu 132 (hwid 132) Ready to die...
>> [  447.713534] cpu 133 (hwid 133) Ready to die...
>> [  447.714064] Querying DEAD? cpu 134 (134) shows 2
>>
>> This is a race between one CPU stopping and another one calling
>> pseries_cpu_die() to wait for it to stop. That function does a short bus=
y
>> loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
>> that it is stopped, but I think there's a lot for the stopping CPU to do
>> which may take longer than this loop allows.
>>
>> As can be seen in the dmesg right before or after the "Querying DEAD?"
>> messages, if pseries_cpu_die() waited a little longer it would have seen
>> the CPU in the stopped state.
>>
>> What I think is going on is that CPU 134 was inactive at the time it was
>> unplugged. In that case, dlpar_offline_cpu() calls H_PROD on that CPU an=
d
>> immediately calls pseries_cpu_die(). Meanwhile, the prodded CPU activate=
s
>> and start the process of stopping itself. The busy loop is not long enou=
gh
>> to allow for the CPU to wake up and complete the stopping process.
>>
>> This can be a problem because if the busy loop finishes too early, then =
the
>> kernel may offline another CPU before the previous one finished dying,
>> which would lead to two concurrent calls to rtas-stop-self, which is
>> prohibited by the PAPR.
>>
>> We can make the race a lot more even if we only start querying if the CP=
U
>> is stopped when the stopping CPU is close to call rtas_stop_self(). Sinc=
e
>> pseries_mach_cpu_die() sets the CPU current state to offline almost
>> immediately before calling rtas_stop_self(), we use that as a signal tha=
t
>> it is either already stopped or very close to that point, and we can sta=
rt
>> the busy loop.
>>
>> As suggested by Michael Ellerman, this patch also changes the busy loop =
to
>> wait for a fixed amount of wall time. Based on the measurements that
>> Gautham did on a POWER9 system, in successful cases of
>> smp_query_cpu_stopped(cpu) returning affirmative, the maximum time spent
>> inside the loop was was 10 ms. This patch loops for 20 ms just be sure.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Analyzed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> I have seen this problem since v4.8. Should this patch go to stable as
>> well?
>>
>> Changes since v2:
>> - Increaded busy loop to 200 iterations so that it can last up to 20 ms
>>   (suggested by Gautham).
>> - Changed commit message to include Gautham's remarks.
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc=
/platforms/pseries/hotplug-cpu.c
>> index 97feb6e79f1a..ac6dc35ab829 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>>  			msleep(1);
>>  		}
>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE) =
{
>> +		/*
>> +		 * If the current state is not offline yet, it means that the
>> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
>> +		 * the process of getting there) didn't have a chance yet to
>> +		 * call rtas_stop_self() and therefore it's too early to query
>> +		 * if the CPU is stopped.
>> +		 */
>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFLIN=
E,
>> +				   100000, 100);

If the CPU state does not go to offline here, you should give up and
return online, right? Otherwise I think query-cpu-stopped-state can
get confused by CPUs in idle and you get a false positive.

That race can still happen, we would really need a sequence count check
over current CPU state to ensure we got a race-free qcss value, but at
least a check here should make the race implausible to hit.

Thanks,
Nick

>> =20
>> -		for (tries =3D 0; tries < 25; tries++) {
>> +		for (tries =3D 0; tries < 200; tries++) {
>>  			cpu_status =3D smp_query_cpu_stopped(pcpu);
>>  			if (cpu_status =3D=3D QCSS_STOPPED ||
>>  			    cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>>  				break;
>> -			cpu_relax();
>> +			udelay(100);
>>  		}
>>  	}
>> =20
>=20
>=20
=
