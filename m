Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D732C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCDC2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VGamvXn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDEFNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:13:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:41055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEFNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554441169;
        bh=4eIURkqK/UfVzHVnael6SRGABpprE24xBGGph2p7MBM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VGamvXn/prof/Rcn/8ovRoI+pa7/H5moAsjHM43XWfW9JTRBTAiIV/FdFWlvKNcB/
         926C5BGak7trZCTB5lzXwNsZrNdyxF3HKWVWIklKjX21Anu7BdcRjHBCntilJeJaPO
         dc1NV4UwwFMIseFNyr6xoeB4RSFLbxKwWiwnElBs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from notebook.internal ([84.160.215.57]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvzF3-1grRKG0Qlp-017ost; Fri, 05
 Apr 2019 07:12:49 +0200
From:   Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@gmx.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 072/246] drm/amd/display: Fix reference counting for struct dc_sink.
Date:   Fri, 05 Apr 2019 07:12:47 +0200
Message-ID: <4990954.l4Ku8jBaGM@notebook.internal>
In-Reply-To: <20190404084621.660309707@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org> <20190404084621.660309707@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:FqWi0a6PqeZia0kYrOQ3oMxIQmuh16HSUnGFcVXj+va+OVVq/1l
 z3aTtXkbwkIEOmWCu7Fe6wvbhTq+YEZ/9DNbz0hxdjaf2DtV02f1E2QsFKoxIE6f0HTAbkO
 YpiYWCgISJMC6ko00UD8BKl9XUhKAHzgJ0y+hak4arMfRJDe/yjkfZY2EOcGRxzVWpIMKTm
 eQExSInbNayLPAkuGTTRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGSlUaDv3FU=:fHPZQk8wEQo5lraaV7ozV+
 pswy6kU/hWO4D0BLGwnhyucfT5dF4D/CsLX75IJS5iS431ZQuwzTnAuUrE8g2MVCca5YdBFqB
 ZPVeT8gHtvVNegx9Oibgd7x5+xrjFs0MkZYIb9PkS8/KvvnHr0B5TfT037PtvwyhifdKXK8Y0
 U0VaizgtEq0seSWuu/rSLO7e5CPL3FSxnMBGZS1iAGRePoXB9hxHTvD3m2Vd79a4IjCTNkV/H
 2TNiq7kO7a73viuh2ELJdXtPwb2+j07JRh3/r0r00TuV/IyokeAE34t472tHKfDSxG2cnLW3E
 41o77iNOzgPA7MLpV0If0CHAJ3XaEMrMrGFXXzS4zkh/BCs8fzzPBnIbgQjyAKNYi/ddOkiQw
 qxmagLaGPXj+F7ofrV0AFx5bCzV7Dz3akKKiBM9pFPHcCcWY6SojrfuaXnV1vCybBjpLYOQLT
 WaFL/NByIB1XOrBE/N4ipe6aqrvb3kcYFPqInI+ZKjD33lGszXj4lTuACIuReeSSQEshAD0Oa
 azy0Dt+q3A9cH/owf1j0xxAZ8zHo5PNjCQnqYL6uEL6qwLFk+lsBHJM5PiUDtfA8IdrbSjfZt
 0DCWLnUQnmmXj6K9tqqTxnoF9Q+lJUpnwEGhy0li9R47R1EekptWLVCh0jfjhLLw/T1Y5ZOBA
 vZSu0C33w9TSUlv3O0SJfpDajcY0gQ0ASHSKg6Zb9f5W7r8d76IRX1HGn3MposT29anL333th
 f///KvjVlXUtC96TcaxONOu3UmgGypeWk6Yt11dD2ieFqvxYXYMnXL+oPUgl74bpBJk1e8R6b
 z5oD3w/6zgkmhTRaA4HJtPLolX4U/Fuz8PMavc8M9JVT3hsvFR6IqZoSjBPD0LHtIJdtExSrA
 bNDCqxcxHl8B+GS7NFCJLkeqRs3pQH7+hYB3P/AdIU+aFiEKbFD1mHhUE2t3QvmYp5atbvioU
 FkGm8RRZESg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

as I mentioned in the commit message, I saw more fixes to that area in Alex
Deuchers queue when I fed that to Alex. There is one fix that I can think of
that interacts with my fixes. Means, we may get unwanted side effects of my
patch without the fix mentioned below. With that below patch also selected,
I think we should be ok for stable.
Alex, AMD people, your opinion?

The one that I can spot not already in linux-5.0.y is:

commit 3f01f098a4e2ef30ef628497c43a3d568e720376
Author: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Date:   Thu Jan 24 11:46:49 2019 -0500

    drm/amd/display: Clear dc_sink after it gets released
   =20
    [Why]
    The dc_sink was released but the pointer on the aconnector was
    not cleared.
   =20
    [How]
    Clear it.

best

Mathias


On Thursday, 4 April 2019 10:46:12 CEST Greg Kroah-Hartman wrote:
> 5.0-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> [ Upstream commit dcd5fb82ffb484124203aa339733663ac0b059f3 ]
>=20
> Reference counting in amdgpu_dm_connector for amdgpu_dm_connector::dc_sink
> and amdgpu_dm_connector::dc_em_sink as well as in dc_link::local_sink see=
ms
> to be out of shape. Thus make reference counting consistent for these
> members and just plain increment the reference count when the variable
> gets assigned and decrement when the pointer is set to zero or replaced.
> Also simplify reference counting in selected function sopes to be sure the
> reference is released in any case. In some cases add NULL pointer check
> before dereferencing.
> At a hand full of places a comment is placed to stat that the reference
> increment happened already somewhere else.
>=20
> This actually fixes the following kernel bug on my system when enabling
> display core in amdgpu. There are some more similar bug reports around,
> so it probably helps at more places.
>=20
>    kernel BUG at mm/slub.c:294!
>    invalid opcode: 0000 [#1] SMP PTI
>    CPU: 9 PID: 1180 Comm: Xorg Not tainted 5.0.0-rc1+ #2
>    Hardware name: Supermicro X10DAi/X10DAI, BIOS 3.0a 02/05/2018
>    RIP: 0010:__slab_free+0x1e2/0x3d0
>    Code: 8b 54 24 30 48 89 4c 24 28 e8 da fb ff ff 4c 8b 54 24 28 85 c0 0=
f 85 67 fe ff ff 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 49 3b=
 5c 24 28 75 ab 48 8b 44 24 30 49 89 4c 24 28 49 89 44
>    RSP: 0018:ffffb0978589fa90 EFLAGS: 00010246
>    RAX: ffff92f12806c400 RBX: 0000000080200019 RCX: ffff92f12806c400
>    RDX: ffff92f12806c400 RSI: ffffdd6421a01a00 RDI: ffff92ed2f406e80
>    RBP: ffffb0978589fb40 R08: 0000000000000001 R09: ffffffffc0ee4748
>    R10: ffff92f12806c400 R11: 0000000000000001 R12: ffffdd6421a01a00
>    R13: ffff92f12806c400 R14: ffff92ed2f406e80 R15: ffffdd6421a01a20
>    FS:  00007f4170be0ac0(0000) GS:ffff92ed2fb40000(0000) knlGS:0000000000=
000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000562818aaa000 CR3: 000000045745a002 CR4: 00000000003606e0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     ? drm_dbg+0x87/0x90 [drm]
>     dc_stream_release+0x28/0x50 [amdgpu]
>     amdgpu_dm_connector_mode_valid+0xb4/0x1f0 [amdgpu]
>     drm_helper_probe_single_connector_modes+0x492/0x6b0 [drm_kms_helper]
>     drm_mode_getconnector+0x457/0x490 [drm]
>     ? drm_connector_property_set_ioctl+0x60/0x60 [drm]
>     drm_ioctl_kernel+0xa9/0xf0 [drm]
>     drm_ioctl+0x201/0x3a0 [drm]
>     ? drm_connector_property_set_ioctl+0x60/0x60 [drm]
>     amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
>     do_vfs_ioctl+0xa4/0x630
>     ? __sys_recvmsg+0x83/0xa0
>     ksys_ioctl+0x60/0x90
>     __x64_sys_ioctl+0x16/0x20
>     do_syscall_64+0x5b/0x160
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    RIP: 0033:0x7f417110809b
>    Code: 0f 1e fa 48 8b 05 ed bd 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff f=
f ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0=
 ff ff 73 01 c3 48 8b 0d bd bd 0c 00 f7 d8 64 89 01 48
>    RSP: 002b:00007ffdd8d1c268 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 0000562818a8ebc0 RCX: 00007f417110809b
>    RDX: 00007ffdd8d1c2a0 RSI: 00000000c05064a7 RDI: 0000000000000012
>    RBP: 00007ffdd8d1c2a0 R08: 0000562819012280 R09: 0000000000000007
>    R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c05064a7
>    R13: 0000000000000012 R14: 0000000000000012 R15: 00007ffdd8d1c2a0
>    Modules linked in: nfsv4 dns_resolver nfs lockd grace fscache fuse vfa=
t fat amdgpu intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coret=
emp kvm_intel kvm irqbypass crct10dif_pclmul chash gpu_sched crc32_pclmul s=
nd_hda_codec_realtek ghash_clmulni_intel amd_iommu_v2 iTCO_wdt iTCO_vendor_=
support ttm snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_=
intel drm_kms_helper snd_hda_codec intel_cstate snd_hda_core drm snd_hwdep =
snd_seq snd_seq_device intel_uncore snd_pcm intel_rapl_perf snd_timer snd s=
oundcore ioatdma pcspkr intel_wmi_thunderbolt mxm_wmi i2c_i801 lpc_ich pcc_=
cpufreq auth_rpcgss sunrpc igb crc32c_intel i2c_algo_bit dca wmi hid_cherry=
 analog gameport joydev
>=20
> This patch is based on agd5f/drm-next-5.1-wip. This patch does not require
> all of that, but agd5f/drm-next-5.1-wip contains at least one more dc_sink
> counting fix that I could spot.
>=20
> Signed-off-by: Mathias Fr=F6hlich <Mathias.Froehlich@web.de>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++++++++++++----
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  1 +
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  1 +
>  3 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 636d14a60952..6d77fd966dbd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -886,6 +886,7 @@ static void emulated_link_detect(struct dc_link *link)
>  		return;
>  	}
> =20
> +	/* dc_sink_create returns a new reference */
>  	link->local_sink =3D sink;
> =20
>  	edid_status =3D dm_helpers_read_local_edid(
> @@ -952,6 +953,8 @@ static int dm_resume(void *handle)
>  		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
>  			aconnector->fake_enable =3D false;
> =20
> +		if (aconnector->dc_sink)
> +			dc_sink_release(aconnector->dc_sink);
>  		aconnector->dc_sink =3D NULL;
>  		amdgpu_dm_update_connector_after_detect(aconnector);
>  		mutex_unlock(&aconnector->hpd_lock);
> @@ -1061,6 +1064,8 @@ amdgpu_dm_update_connector_after_detect(struct amdg=
pu_dm_connector *aconnector)
> =20
> =20
>  	sink =3D aconnector->dc_link->local_sink;
> +	if (sink)
> +		dc_sink_retain(sink);
> =20
>  	/*
>  	 * Edid mgmt connector gets first update only in mode_valid hook and th=
en
> @@ -1085,21 +1090,24 @@ amdgpu_dm_update_connector_after_detect(struct am=
dgpu_dm_connector *aconnector)
>  				 * to it anymore after disconnect, so on next crtc to connector
>  				 * reshuffle by UMD we will get into unwanted dc_sink release
>  				 */
> -				if (aconnector->dc_sink !=3D aconnector->dc_em_sink)
> -					dc_sink_release(aconnector->dc_sink);
> +				dc_sink_release(aconnector->dc_sink);
>  			}
>  			aconnector->dc_sink =3D sink;
> +			dc_sink_retain(aconnector->dc_sink);
>  			amdgpu_dm_update_freesync_caps(connector,
>  					aconnector->edid);
>  		} else {
>  			amdgpu_dm_update_freesync_caps(connector, NULL);
> -			if (!aconnector->dc_sink)
> +			if (!aconnector->dc_sink) {
>  				aconnector->dc_sink =3D aconnector->dc_em_sink;
> -			else if (aconnector->dc_sink !=3D aconnector->dc_em_sink)
>  				dc_sink_retain(aconnector->dc_sink);
> +			}
>  		}
> =20
>  		mutex_unlock(&dev->mode_config.mutex);
> +
> +		if (sink)
> +			dc_sink_release(sink);
>  		return;
>  	}
> =20
> @@ -1107,8 +1115,10 @@ amdgpu_dm_update_connector_after_detect(struct amd=
gpu_dm_connector *aconnector)
>  	 * TODO: temporary guard to look for proper fix
>  	 * if this sink is MST sink, we should not do anything
>  	 */
> -	if (sink && sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
> +	if (sink && sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST) {
> +		dc_sink_release(sink);
>  		return;
> +	}
> =20
>  	if (aconnector->dc_sink =3D=3D sink) {
>  		/*
> @@ -1117,6 +1127,8 @@ amdgpu_dm_update_connector_after_detect(struct amdg=
pu_dm_connector *aconnector)
>  		 */
>  		DRM_DEBUG_DRIVER("DCHPD: connector_id=3D%d: dc_sink didn't change.\n",
>  				aconnector->connector_id);
> +		if (sink)
> +			dc_sink_release(sink);
>  		return;
>  	}
> =20
> @@ -1138,6 +1150,7 @@ amdgpu_dm_update_connector_after_detect(struct amdg=
pu_dm_connector *aconnector)
>  			amdgpu_dm_update_freesync_caps(connector, NULL);
> =20
>  		aconnector->dc_sink =3D sink;
> +		dc_sink_retain(aconnector->dc_sink);
>  		if (sink->dc_edid.length =3D=3D 0) {
>  			aconnector->edid =3D NULL;
>  			drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
> @@ -1158,11 +1171,15 @@ amdgpu_dm_update_connector_after_detect(struct am=
dgpu_dm_connector *aconnector)
>  		amdgpu_dm_update_freesync_caps(connector, NULL);
>  		drm_connector_update_edid_property(connector, NULL);
>  		aconnector->num_modes =3D 0;
> +		dc_sink_release(aconnector->dc_sink);
>  		aconnector->dc_sink =3D NULL;
>  		aconnector->edid =3D NULL;
>  	}
> =20
>  	mutex_unlock(&dev->mode_config.mutex);
> +
> +	if (sink)
> +		dc_sink_release(sink);
>  }
> =20
>  static void handle_hpd_irq(void *param)
> @@ -2908,6 +2925,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
>  		}
>  	} else {
>  		sink =3D aconnector->dc_sink;
> +		dc_sink_retain(sink);
>  	}
> =20
>  	stream =3D dc_create_stream_for_sink(sink);
> @@ -2974,8 +2992,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
>  		stream->ignore_msa_timing_param =3D true;
> =20
>  finish:
> -	if (sink && sink->sink_signal =3D=3D SIGNAL_TYPE_VIRTUAL && aconnector-=
>base.force !=3D DRM_FORCE_ON)
> -		dc_sink_release(sink);
> +	dc_sink_release(sink);
> =20
>  	return stream;
>  }
> @@ -3233,6 +3250,14 @@ static void amdgpu_dm_connector_destroy(struct drm=
_connector *connector)
>  		dm->backlight_dev =3D NULL;
>  	}
>  #endif
> +
> +	if (aconnector->dc_em_sink)
> +		dc_sink_release(aconnector->dc_em_sink);
> +	aconnector->dc_em_sink =3D NULL;
> +	if (aconnector->dc_sink)
> +		dc_sink_release(aconnector->dc_sink);
> +	aconnector->dc_sink =3D NULL;
> +
>  	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
>  	drm_connector_unregister(connector);
>  	drm_connector_cleanup(connector);
> @@ -3330,10 +3355,12 @@ static void create_eml_sink(struct amdgpu_dm_conn=
ector *aconnector)
>  		(edid->extensions + 1) * EDID_LENGTH,
>  		&init_params);
> =20
> -	if (aconnector->base.force =3D=3D DRM_FORCE_ON)
> +	if (aconnector->base.force =3D=3D DRM_FORCE_ON) {
>  		aconnector->dc_sink =3D aconnector->dc_link->local_sink ?
>  		aconnector->dc_link->local_sink :
>  		aconnector->dc_em_sink;
> +		dc_sink_retain(aconnector->dc_sink);
> +	}
>  }
> =20
>  static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 1b0d209d8367..3b95a637b508 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -239,6 +239,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>  			&init_params);
> =20
>  		dc_sink->priv =3D aconnector;
> +		/* dc_link_add_remote_sink returns a new reference */
>  		aconnector->dc_sink =3D dc_sink;
> =20
>  		if (aconnector->dc_sink)
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index b0265dbebd4c..583eb367850f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -792,6 +792,7 @@ bool dc_link_detect(struct dc_link *link, enum dc_det=
ect_reason reason)
>  		sink->dongle_max_pix_clk =3D sink_caps.max_hdmi_pixel_clock;
>  		sink->converter_disable_audio =3D converter_disable_audio;
> =20
> +		/* dc_sink_create returns a new reference */
>  		link->local_sink =3D sink;
> =20
>  		edid_status =3D dm_helpers_read_local_edid(
>=20




